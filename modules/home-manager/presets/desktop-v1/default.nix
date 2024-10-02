{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v1;
in {
  imports = [
    ./hyprland.nix
    ./swaylock.nix
    ./foot.nix
    ./mako.nix
    ./rofi.nix
    ./waybar.nix
    ./packages.nix
    ./firefox.nix
    ./playerctl.nix
    ./zsh.nix
    ./udiskie.nix
    ./tmux.nix
    ./neovim.nix
  ];
  options.modules.presets.desktop-v1.enable =
    mkEnableOption "desktop-v1 preset";

  config = mkIf cfg.enable {
    modules.presets.desktop-v1.hyprland.enable = mkDefault true;
    modules.presets.desktop-v1.swaylock.enable = mkDefault true;
    modules.presets.desktop-v1.foot.enable = mkDefault true;
    modules.presets.desktop-v1.mako.enable = mkDefault true;
    modules.presets.desktop-v1.rofi.enable = mkDefault true;
    modules.presets.desktop-v1.waybar.enable = mkDefault true;
    modules.presets.desktop-v1.packages.enable = mkDefault true;
    modules.presets.desktop-v1.firefox.enable = mkDefault true;
    modules.presets.desktop-v1.playerctl.enable = mkDefault true;
    modules.presets.desktop-v1.zsh.enable = mkDefault true;
    modules.presets.desktop-v1.udiskie.enable = mkDefault true;
    modules.presets.desktop-v1.tmux.enable = mkDefault true;
    modules.presets.desktop-v1.neovim.enable = mkDefault true;
  };
}
