{ config, pkgs, outputs, ...}:
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
  ];

  networking.hostName = "tweety";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
      packages = [];
    };
    # more
  };
  home-manager.users.${admin} = import ../../home/${admin}/${config.networking.hostName}.nix;

  services.openssh.enable = true;
}
