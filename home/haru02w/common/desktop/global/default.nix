{ inputs, ... }:
{
  imports = [ ./firefox.nix ./packages.nix ./services.nix ];

  wallpaper = ../../non-nix/wallpapers/win-xp_night.jpg;
  colorScheme = inputs.nix-colors.colorSchemes.tokyodark-terminal;
}
