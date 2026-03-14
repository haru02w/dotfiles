{
  inputs,
  config,
  lib,
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
    LD_LIBRARY_PATH="/run/opengl-driver/lib";
  };
  boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

  programs.nix-ld = {
    enable = lib.mkForce true;
    libraries = [ config.boot.kernelPackages.nvidia_x11 ];
  };
  #ignore lid close

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
  };
}
