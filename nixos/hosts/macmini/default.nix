# Mac mini (Late 2012): everything specific to this machine
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/server.nix
  ];

  networking.hostName = "macmini";

  # Apple SMC driver (fans, sensors) + Intel CPU temperatures
  boot.kernelModules = [ "applesmc" "coretemp" ];

  # Fan control through applesmc; min/max fan speeds are read from the SMC
  services.mbpfan = {
    enable = true;
    settings.general = {
      low_temp = 55;   # °C: below this, fan stays at minimum
      high_temp = 65;  # °C: fan ramps up from here
      max_temp = 80;   # °C: fan at full speed
    };
  };

  # Power on automatically when electricity returns after an outage.
  # Register 0xA4 of the Intel LPC controller (PCI 00:1f.0) resets every boot,
  # so this service writes it each time.
  systemd.services.autopoweron = {
    description = "Mac mini: power on after power loss";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.pciutils}/bin/setpci -s 0:1f.0 0xa4.b=0";
    };
  };

  # Ports this machine opens (SSH's 22 is handled by services.openssh)
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];

  # Per machine. Use the value from YOUR generated file, never change it
  system.stateVersion = "26.05";
}
