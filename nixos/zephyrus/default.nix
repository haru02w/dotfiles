{ pkgs, inputs, outputs, ... }:
{
  imports = (builtins.attrValues outputs.nixosModules) ++ [
    ../features/main_user.nix
    ../features/impermanence.nix
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

  users.main_user = "haru02w";
  networking.hostName = "zephyrus";
  networking.extraHosts =
  ''
    192.168.0.2 proxmox.lan
    192.168.0.200 rpi3.lan
  '';

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot = { enable = true; };
      efi.canTouchEfiVariables = true;
    };
  };

}
