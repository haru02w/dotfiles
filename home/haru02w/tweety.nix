{ pkgs, ... }: {
  imports = [
    ../features/common/global.nix
    ../features/desktop/hyprland
    ../features/desktop/hyprland/swaylock.nix
    ../features/gui-packages.nix
    ../features/secrets.nix
  ];

  home.packages = with pkgs; [ distrobox ];
}
