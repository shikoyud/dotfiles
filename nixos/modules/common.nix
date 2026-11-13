# Shared by every machine
{ config, pkgs, lib, ... }:

{
  ########## Boot (all machines are UEFI) ##########
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10; # max boot menu entries (keeps /boot from filling up)
  boot.loader.efi.canTouchEfiVariables = true;      # register NixOS in the firmware
  boot.loader.timeout = 3;

  hardware.enableRedistributableFirmware = true;    # firmware blobs (network chips etc.)

  ########## Basics ##########
  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  ########## User ##########
  users.users.shiko = {
    isNormalUser = true;
    description = "shiko";
    extraGroups = [ "wheel" ];                      # wheel = allowed to use sudo
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGms+njbYDaD4oS1zHQjED4EfwjEWECnmqNr++eomwrk"
    ];
  };

  ########## Shell ##########
  programs.zsh = {
    enable = true;
    enableCompletion = true;          # Tab completion for commands, flags, git branches, etc.
    autosuggestions.enable = true;    # grey suggestion from your history; press → to accept (like fish)
    syntaxHighlighting.enable = true; # valid commands green, typos red (like fish)
    histSize = 10000;
    setOptions = [ "HIST_IGNORE_DUPS" "SHARE_HISTORY" "HIST_FCNTL_LOCK" "AUTO_CD" ];

    interactiveShellInit = ''
      # Completion menu you can move through with the arrow keys; case-insensitive
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

      # Up/Down search history for lines starting with what you typed (like fish)
      autoload -U up-line-or-beginning-search down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey "^[[A" up-line-or-beginning-search
      bindkey "^[[B" down-line-or-beginning-search
    '';
  };

  users.users.shiko.shell = pkgs.zsh;   # make zsh your login shell

  programs.starship.enable = true;      # your prompt (reads ~/.config/starship.toml from your dotfiles)

  programs.fzf = {
    keybindings = true;                 # Ctrl+R = fuzzy history search, Ctrl+T = fuzzy file picker
    fuzzyCompletion = true;             # type **<Tab> to fuzzy-complete paths
  };

  ########## SSH ##########
  services.openssh = {
    enable = true;                                  # also opens port 22 in the firewall
    settings = {
      PasswordAuthentication = false;               # keys only
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "shiko" ];
    };
  };

  ########## Firewall (each host opens its own ports) ##########
  networking.firewall.enable = true;

  ########## Storage & memory ##########
  services.fstrim.enable = true;                    # weekly SSD TRIM
  zramSwap = {
    enable = true;                                  # compressed swap in RAM, used before disk swap
    memoryPercent = lib.mkDefault 25;               # a host can override this
  };

  ########## Nix ##########
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    trusted-users = [ "root" "shiko" ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  ########## Packages ##########
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  environment.systemPackages = with pkgs; [
    git curl wget btop tmux starship
    pciutils usbutils lm_sensors smartmontools dnsutils
    ripgrep fd jq tree-sitter gcc gnumake unzip
    zoxide fastfetch nmap
  ];
}
