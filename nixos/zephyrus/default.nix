{ config, pkgs, inputs, outputs, ...}:
let
  admin = "haru02w";
  ifGroupsExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = (builtins.attrValues outputs.nixosModules) ++ [
    ./hardware-configuration.nix
    ../features/common/global.nix
    ../features/common/hyprland-desktop.nix
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];
  hardware.laptop.enable = true;

  networking.hostName = "zephyrus";

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Users
  users.users = {
    "${admin}"= {
      isNormalUser = true;
      extraGroups = ifGroupsExist [ 
        "wheel"
        "networkmanager"
        "video"
        "audio"
        "libvirtd"
        "network"
        "git"
      ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [];
    };
    # more
  };
  home-manager.users.${admin} = import ../../home/${admin}/${config.networking.hostName}.nix;
}
