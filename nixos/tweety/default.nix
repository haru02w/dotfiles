{ outputs, ... }:
{
  imports = (builtins.attrValues outputs.nixosModules) ++ [
    ../features/users/haru02w.nix
    ./hardware-configuration.nix
    ../features/quietboot.nix
    ../features/common/global.nix
    ../features/common/hyprland-desktop.nix
  ];
  networking.hostName = "tweety";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}
