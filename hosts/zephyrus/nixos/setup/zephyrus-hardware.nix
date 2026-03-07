{
  inputs,
  config,
  ...
}: {
  # G14 Hardware
  imports = [inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    dynamicBoost.enable = true;
  };
  services.asusd = {
    enable = true;
  };
  environment.sessionVariables = rec {
    AQ_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    WLR_DRM_DEVICES = AQ_DRM_DEVICES;
    WLR_RENDER_NO_EXPLICIT_SYNC = 1;
  };
  boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
  #ignore lid close

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
  };
}
