{ pkgs, inputs, ... }:

{
  imports = [ 
    inputs.hyprland.homeManagerModules.default
    ./hyprland.nix
    ./waybar.nix
    ./rofi.nix
    ./foot.nix
    ../playerctl.nix
  ];

  home.packages = with pkgs; [
    rofi-wayland
    waybar
    libnotify
    brightnessctl
    grimblast
    wl-clipboard
  ];

  services.mako = {
    enable = true;
    ignoreTimeout = true;
    defaultTimeout = 5000;
  };
}
