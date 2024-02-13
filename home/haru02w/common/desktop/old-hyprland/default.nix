{ pkgs, lib,  ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./rofi.nix
    ./foot.nix
  ];

  # desktop.wallpaper = ../../dotconfig/wallpapers/win-xp_night.jpg;

  home.packages = with pkgs; [
    swaybg
    wl-clipboard
    rofi-wayland
    waybar
    libnotify
    brightnessctl
    grimblast
  ];

  services.mako = {
    enable = true;
    ignoreTimeout = true;
    defaultTimeout = 5000;
  };
}
