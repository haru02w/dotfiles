{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v1;
in {
  options.modules.presets.desktop-v1.enable =
    mkEnableOption "desktop-v1 preset";
  config = mkIf cfg.enable {
    stylix = {
      enable = true;

      image = ../../../../wallpapers/localhost.jpg;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark-terminal.yaml";

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 16;
      };

      fonts = {
        monospace = {
          package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
          name = "FiraCode Nerd Font Mono";
        };

        sansSerif = {
          package = pkgs.open-sans;
          name = "Open Sans";
        };

        serif = {
          package = pkgs.roboto-serif;
          name = "Roboto Serif";
        };

        sizes = {
          desktop = 12;
          popups = 10;
          terminal = 14;
          applications = 12;
        };
      };
    };

    services.udisks2.enable = true;
    programs.zsh.enable = true;
    modules.programs.pipewire.enable = mkDefault true;
    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        auth_fails = 3;
        clear_password = true;
        default_input = "password";
        save = true;
        load = true;
        numlock = true;
      };
    };

    modules.programs.hyprland.enable = mkDefault true;
    modules.fhsHelpers.enable = mkDefault true;
    environment.systemPackages = with pkgs; [
      neovim # text editor
      git # version control system
      wget # downloader
    ];
  };
}
