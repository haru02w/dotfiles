{ pkgs, inputs, outputs, ... }:
{
  imports = (builtins.attrValues outputs.nixosModules) ++ [
    ../features/user_haru02w.nix
    ./hardware-configuration.nix
    ../features/quietboot.nix
    ../features/common/global.nix
    ../features/common/hyprland-desktop.nix
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  hardware.nvidia = {
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    dynamicBoost.enable = true;
  };

  hardware.laptop = {
    enable = true;
    wifi.enableOpenvpn = true;
  };

  environment.sessionVariables = { WLR_DRM_DEVICES = "/dev/dri/card0"; };

  networking.hostName = "zephyrus";

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot = { enable = true; };
      efi.canTouchEfiVariables = true;
    };
  };

}
