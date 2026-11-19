# Runs the dismess server on macmini: the Node server, LiveKit (voice/video), Caddy (HTTPS)
# and Namecheap dynamic DNS.
#
# Lives in ~/dotfiles/nixos/modules/dismess.nix, imported from hosts/macmini/default.nix.
# Apply with:  sudo nixos-rebuild switch --flake ~/dotfiles/nixos#macmini
#
# Secret files it reads (never in git):
#   /home/shiko/dismess/server/.env   JWT_SECRET, LIVEKIT_*, SPOTIFY_*, ...
#   /etc/dismess/livekit-keys          one line:  dismess: <same secret as LIVEKIT_API_SECRET>
#   /etc/dismess/namecheap-ddns        one line:  your Namecheap Dynamic DNS password
#   /etc/dismess/voice-env             one line:  VOICE_RELAY_SECRET=<same as in server/.env>
#
# After a `git pull` in ~/dismess: `cd server && npm install` (if packages changed) and
# `sudo systemctl restart dismess`. If server/voice-relay changed too: `nix flake update dismess`
# in ~/dotfiles/nixos, then the nixos-rebuild above.
{ config, lib, pkgs, utils, inputs, ... }:

let
  user = "shiko";
  repo = "/home/${user}/dismess";
  domain = "shikoyud.com";
  node = pkgs.nodejs_26;

  # LiveKit's settings (https://github.com/livekit/livekit/blob/master/config-sample.yaml)
  livekitConfig = pkgs.writeText "livekit.json" (builtins.toJSON {
    port = 7880; # only reached through Caddy (lk.shikoyud.com)
    rtc = {
      tcp_port = 7881; # fallback for friends whose network blocks UDP
      udp_port = 7882; # all voice/video goes over this one UDP port (forwarded on the router)
      use_external_ip = true; # tell friends the house's public IP, found with STUN
      stun_servers = [ "stun.l.google.com:19302" "stun.cloudflare.com:3478" ];
    };
    room = {
      # Each person can be in the room up to 3 times (the app page, "<id>~voice" for native audio,
      # "<id>~listener"), plus "__music". 6 was too few once native audio became the default.
      max_participants = 30;
      empty_timeout = 300;
    };
    logging.level = "info";
  });

  # Runs (as root) before LiveKit starts:
  # 1. Waits (up to 2 min) until the internet answers. LiveKit asks a STUN server for the house's
  #    public IPv4 only once, at start; too early and friends without IPv6 can't connect at all
  #    ("could not establish pc connection").
  # 2. LiveKit then double-checks that IP by sending a packet to <public IP>:7882 and waiting for
  #    it to come back. The router doesn't loop packets from inside the house back in
  #    ("hairpin NAT"), so the check fails and LiveKit throws the IPv4 away. A small firewall rule
  #    on this machine sends packets for our own public IP straight back to ourselves instead.
  # 3. Remembers the public IP, so the timer below can restart LiveKit when it changes.
  livekitPrepare = pkgs.writeShellScript "livekit-prepare" ''
    PATH=${lib.makeBinPath [ pkgs.curl pkgs.iproute2 pkgs.gawk pkgs.coreutils config.networking.firewall.package ]}
    for i in $(seq 1 60); do
      pub=$(curl -4 -sf --max-time 3 https://api.ipify.org) && break
      sleep 2
    done
    if [ -z "$pub" ]; then echo "internet not reachable, starting LiveKit anyway"; exit 0; fi
    lan=$(ip -4 route get 1.1.1.1 | awk '{for (i = 1; i < NF; i++) if ($i == "src") print $(i + 1)}')
    echo "public IPv4 $pub, LAN IPv4 $lan"
    echo "$pub" > /run/dismess-public-ip
    iptables -t nat -N DISMESS_HAIRPIN 2>/dev/null || true
    iptables -t nat -F DISMESS_HAIRPIN
    iptables -t nat -C OUTPUT -j DISMESS_HAIRPIN 2>/dev/null || iptables -t nat -A OUTPUT -j DISMESS_HAIRPIN
    [ -n "$lan" ] && iptables -t nat -A DISMESS_HAIRPIN -d "$pub" -j DNAT --to-destination "$lan"
    exit 0
  '';

  # Every 5 minutes: if the house's public IP changed (the ISP does that sometimes), restart
  # LiveKit so it hands out the new one.
  livekitIpCheck = pkgs.writeShellScript "livekit-ip-check" ''
    now=$(${pkgs.curl}/bin/curl -4 -sf --max-time 5 https://api.ipify.org) || exit 0
    if [ "$now" != "$(cat /run/dismess-public-ip 2>/dev/null)" ]; then
      echo "public IP is now $now, restarting LiveKit"
      ${pkgs.systemd}/bin/systemctl restart livekit
    fi
  '';
in
{
  # ---- the voice relay (dismess-voice, server/voice-relay in the repo; its module lives there) ----
  # Our own voice server for the app's "dismess relay" transport. UDP 7883 (forward it on the
  # router too). Its secret is in /etc/dismess/voice-env; the Node server's .env has the same
  # VOICE_RELAY_SECRET plus VOICE_RELAY_PUBLIC and VOICE_RELAY_FINGERPRINT.
  imports = [ "${inputs.dismess}/server/voice-relay/nixos.nix" ];
  services.dismess-voice = {
    enable = true;
    src = "${inputs.dismess}/server/voice-relay";
  };

  # ---- the dismess server (server/ in the repo, started with `npm start` = tsx src/index.ts) ----
  systemd.services.dismess = {
    description = "dismess server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "livekit.service" ];
    wants = [ "network-online.target" ];

    # programs the server starts: yt-dlp (which runs node for YouTube's JavaScript) and ffmpeg
    path = [ node pkgs.yt-dlp pkgs.ffmpeg pkgs.bash ];

    environment = {
      NODE_ENV = "production";
      # @livekit/rtc-node (the music bot's connection to LiveKit) is a prebuilt library that
      # needs libgcc_s, which NixOS doesn't keep in /usr/lib.
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };

    serviceConfig = {
      User = user;
      WorkingDirectory = "${repo}/server"; # the server reads .env, data/, releases/ and public/ from here
      ExecStart = "${node}/bin/npm start";
      Restart = "always";
      RestartSec = 3;
      PrivateTmp = true; # song downloads in /tmp/dismess-music stay private to the service
    };
  };

  # ---- LiveKit (voice and screen share) ----
  # We use the NixOS livekit service for its user and secret handling, but give it our own config
  # file: the module always adds a UDP port range (50000-51000) that would compete with our
  # single forwarded UDP port 7882.
  services.livekit = {
    enable = true;
    keyFile = "/etc/dismess/livekit-keys";
  };
  systemd.services.livekit = {
    serviceConfig = {
      ExecStart = lib.mkForce (utils.escapeSystemdExecArgs [
        (lib.getExe config.services.livekit.package)
        "--config=${livekitConfig}"
        "--key-file=/run/credentials/livekit.service/livekit-secrets"
      ]);
      ExecStartPre = "+${livekitPrepare}"; # "+": runs as root (it changes a firewall rule)
      TimeoutStartSec = 150;
      Restart = lib.mkForce "always";
      RestartSec = 5;
      # On stop, LiveKit waits for everyone to leave the room first, so a restart can hang for
      # minutes. Give it 10 s, then systemd kills it (people just reconnect).
      TimeoutStopSec = 10;
    };
  };

  systemd.services.livekit-ip-check = {
    description = "Restart LiveKit when the public IP changes";
    serviceConfig = { Type = "oneshot"; ExecStart = livekitIpCheck; };
  };
  systemd.timers.livekit-ip-check = {
    wantedBy = [ "timers.target" ];
    timerConfig = { OnBootSec = "5min"; OnUnitActiveSec = "5min"; };
  };

  # ---- Caddy: automatic HTTPS for both addresses ----
  services.caddy = {
    enable = true;
    virtualHosts."${domain}".extraConfig = "reverse_proxy localhost:3000";
    virtualHosts."lk.${domain}".extraConfig = "reverse_proxy localhost:7880";
  };

  # ---- Namecheap dynamic DNS: keeps shikoyud.com and lk.shikoyud.com pointing at your home IP ----
  # The password is the "Dynamic DNS Password" from Namecheap (Domain List > Manage > Advanced DNS),
  # NOT your account password. Put it alone in /etc/dismess/namecheap-ddns (chmod 600).
  services.ddclient = {
    enable = true;
    protocol = "namecheap";
    server = "dynamicdns.park-your-domain.com";
    username = domain;
    passwordFile = "/etc/dismess/namecheap-ddns";
    domains = [ "@" "lk" ]; # shikoyud.com and lk.shikoyud.com
    usev4 = "webv4, webv4=ipify-ipv4";
    usev6 = ""; # Namecheap's updater is IPv4 only
    interval = "5min";
  };

  # ---- ports (forward the same ones on the router to this machine) ----
  networking.firewall = {
    allowedTCPPorts = [ 80 443 7881 ];
    allowedUDPPorts = [ 7882 ];
  };

  # handy on the command line: `npm install` in server/, checking yt-dlp, etc.
  environment.systemPackages = [ node pkgs.yt-dlp pkgs.ffmpeg pkgs.git ];
}

