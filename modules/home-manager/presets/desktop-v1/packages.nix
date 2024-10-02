{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v1.packages;
in {
  options.modules.presets.desktop-v1.packages.enable =
    mkEnableOption "desktop-v1 packages";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # GUI
      discord
      webcord

      # CLI
      lazygit
      progress
      libqalculate
      ncdu
      pulsemixer
      btop
      neofetch
      tldr

      # services
      wl-clipboard # clipboard on wayland
      libnotify # notifications
      brightnessctl # change brightness
      grimblast # screenshots
    ];
  };
}
