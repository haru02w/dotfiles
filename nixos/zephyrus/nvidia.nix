{ config, ... }: {
  hardware.nvidia = {
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    dynamicBoost.enable = true;
  };
  environment.etc = {
    "amdcard" = { source = "/dev/dri/by-path/pci-0000:04:00.0-card"; };
    "nvicard" = { source = "/dev/dri/by-path/pci-0000:01:00.0-card"; };
  };
  environment.sessionVariables.WLR_DRM_DEVICES = ''
    /etc/${config.environment.etc."amdcard".target}:/etc/${
      config.environment.etc."nvicard".target
    }
  '';
}
