# For machines that stay on 24/7
{ ... }:

{
  # A server must never go to sleep
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  services.fail2ban.enable = true;                  # bans IPs that keep failing SSH logins
  services.smartd.enable = true;                    # disk health monitoring
  services.journald.extraConfig = "SystemMaxUse=500M";
}
