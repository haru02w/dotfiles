{ pkgs, ... }: {
  fontProfiles = {
    enable = true;
    monospace = {
      package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
      family = "FiraCode Nerd Font Mono";
    };
    regular = { 
      package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
      family = "FiraCode Nerd Font";
    };
  };
}
