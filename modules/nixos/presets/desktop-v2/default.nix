{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v2;
in {
  imports = [
    ./tuigreet.nix
  ];
  options.modules.presets.desktop-v2.enable =
    mkEnableOption "desktop-v2 preset";
  config = mkIf cfg.enable {
    modules.presets.desktop-v2.tuigreet.enable = true;
    stylix = {
      enable = true;

      image = ../../../../wallpapers/localhost.jpg;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark-terminal.yaml";

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 20;
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.fira-code;
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

    xdg.portal = {
      enable = true;
      config.common.default = "wlr";
      wlr.enable = true;
    };

    services.udisks2.enable = true;
    programs.zsh.enable = true;
    modules.programs.pipewire.enable = true;

    modules.fhsHelpers.enable = true;

    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };

    security.pam.services.swaylock = {};

    environment.systemPackages = with pkgs; [
      neovim # text editor
      git # version control system
      wget # downloader
    ];
  };
}
