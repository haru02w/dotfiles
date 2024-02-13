{ inputs, ... }:
let
  wallpaper = ../../non-nix/wallpapers/win-xp_night.jpg;
  colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;
in {
  imports = [
    (import ../global { inherit colorScheme; })
    (import ./hyprland.nix { inherit wallpaper; })
    ./foot.nix
    ./waybar.nix
    ./mako.nix
    ./packages.nix
  ];
}
