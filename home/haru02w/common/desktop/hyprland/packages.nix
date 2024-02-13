{pkgs, ...}:
{
  home.packages = with pkgs; [
    wl-clipboard
    rofi-wayland
    libnotify
    brightnessctl
    grimblast
  ];
}
