{inputs, ...}: {
  # G14 Hardware
  imports = [inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401];

  hardware.nvidia = {
    open = false;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    dynamicBoost.enable = true;
  };
  services.asusd = {
    enable = true;
    enableUserService = true;
  };
  environment.sessionVariables.AQ_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
  boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
  #ignore lid close
  services.logind.extraConfig = ''
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend
    HandleLidSwitchDocked=ignore
  '';
}
