{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v2.packages;
in {
  options.modules.presets.desktop-v2.packages.enable =
    mkEnableOption "desktop-v2 packages";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # GUI
      discord
      vesktop

      # CLI
      lazygit
      progress
      libqalculate
      ncdu
      pulsemixer
      btop
      neofetch
      tldr
      zip
      unzip

      # services
      wl-clipboard # clipboard on wayland
      libnotify # notifications
      brightnessctl # change brightness
      grimblast # screenshots
    ];
  };
}
