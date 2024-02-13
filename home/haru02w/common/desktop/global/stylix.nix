{ pkgs, ... }: {
  stylix = {
    # set wallpaper
    image = ../../non-nix/wallpapers/win-xp_night.jpg;
    # dark mode
    stylix.polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
    fonts = {
      serif = {
        package = pkgs.nerdfonts;
        name = "FiraCode Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.nerdfonts;
        name = "FiraCode Nerd Font Mono";
      };
      monospace = {
        package = pkgs.nerdfonts;
        name = "FiraCode Nerd Font Mono";
      };
      sizes = {
        desktop = 12;
        applications = 16;
        terminal = 16;
        popups = 12;
      };
    };
    opacity = {
      terminal = 1;
      applications = 1;
      popups = 1;
      desktop = 1;
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };
    # targets = { };
  };
}
