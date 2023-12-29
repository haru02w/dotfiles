{ config, pkgs, inputs, outputs, ...}:
let
  admin = "haru02w";
  ifGroupsExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = (builtins.attrValues outputs.nixosModules) ++ [
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

  hardware.laptop.enable = true;

  environment.sessionVariables = {
    WLR_DRM_DEVICES = "/dev/dri/card0";
  };

  networking.hostName = "zephyrus";

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  # Users
  users.users = {
    "${admin}"= {
      isNormalUser = true;
      extraGroups = ifGroupsExist [ 
        "wheel" # Enable ‘sudo’ for the user.
        "networkmanager"
        "video"
        "audio"
        "libvirtd"
        "network"
        "git"
      ]; 
      shell = pkgs.zsh;
      packages = with pkgs; [];
    };
    # more
  };
  home-manager.users.${admin} = import ../../home/${admin}/${config.networking.hostName}.nix;
}
