{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "24.05";

  #ignore lid close
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
    HandleLidSwitchDocked=ignore
  '';
}
