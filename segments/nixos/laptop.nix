{
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  programs.light.enable = true;

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    lidSwitchDocked = "ignore";
  };
}
