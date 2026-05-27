{inputs, ...}: {
  den.aspects.haru02w.nixos = {
    pkgs,
    lib,
    ...
  }: {
    stylix = {
      image = inputs.self.outPath + "/wallpapers/localhost.jpg";
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
  };
}
