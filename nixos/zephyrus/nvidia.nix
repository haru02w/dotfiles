{
  hardware.nvidia = {
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    dynamicBoost.enable = true;
  };
  environment.sessionVariables.WLR_DRM_DEVICES = "/dev/dri/card0";
}
