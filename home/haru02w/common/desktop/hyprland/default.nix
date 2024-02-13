{pkgs, ...}:
{
  imports = [
    ../global # change theme or wallpaper here
    ./hyprland.nix
    ./foot.nix
    ./waybar.nix
    ./mako.nix
    ./packages.nix
  ];

  # extra theming 
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 20;
  };
}
