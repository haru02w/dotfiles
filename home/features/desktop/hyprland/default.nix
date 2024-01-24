{ pkgs, inputs,lib,  ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./hyprland.nix
    ./waybar.nix
    ./rofi.nix
    ./foot.nix
    ../playerctl.nix
  ];

  desktop.wallpaper = ../../dotconfig/wallpapers/win-xp_night.jpg;

  home.packages = with pkgs; [
    swaybg
    wl-clipboard
    rofi-wayland
    waybar
    libnotify
    brightnessctl
    grimblast
  ];

  home.activation.screenshots_folder = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.screenshots
  '';


  services.mako = {
    enable = true;
    ignoreTimeout = true;
    defaultTimeout = 5000;
  };
}
