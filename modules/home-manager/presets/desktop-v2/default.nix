{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v2;
in {
  imports = [
    ./sway.nix
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
  options.modules.presets.desktop-v2.enable =
    mkEnableOption "desktop-v2 preset";

  config = mkIf cfg.enable {
    modules.presets.desktop-v2 = {
      sway.enable = mkDefault true;
      swaylock.enable = mkDefault true;
      foot.enable = mkDefault true;
      mako.enable = mkDefault true;
      rofi.enable = mkDefault true;
      waybar.enable = mkDefault true;
      packages.enable = mkDefault true;
      firefox.enable = mkDefault true;
      playerctl.enable = mkDefault true;
      zsh.enable = mkDefault true;
      udiskie.enable = mkDefault true;
      tmux.enable = mkDefault true;
      neovim.enable = mkDefault true;
    };
  };
}
