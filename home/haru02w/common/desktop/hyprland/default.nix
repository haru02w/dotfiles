{ # TODO: Stylix - seems to be more complete than nix-colors
  imports = [
    ../global
    ./hyprland.nix
    ./foot.nix
    ./waybar.nix
    ./mako.nix
    ./packages.nix
  ];
}
