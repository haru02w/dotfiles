{ inputs, ... }:
let
  wallpaper = ../../non-nix/wallpapers/win-xp_night.jpg;
  colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;
in {
  imports = [ ./firefox.nix ./packages.nix ./services.nix ];
  inherit colorScheme;
  inherit wallpaper;
}
