{ lib, config, pkgs, ... }:
with lib;
let cfg = config.modules.presets.desktop-v1;
in {
  options.modules.presets.desktop-v1.enable =
    mkEnableOption "desktop-v1 preset";
  config = mkIf cfg.enable {
    modules.programs.pipewire.enable = mkDefault true;
    modules.programs.hyprland.enable = mkDefault true;
    modules.fhsHelpers.enable = mkDefault true;
    environment.systemPackages = with pkgs; [
      neovim # text editor
      git # version control system
      wget # downloader
    ];
  };
}
