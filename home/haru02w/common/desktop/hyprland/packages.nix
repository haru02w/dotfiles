{pkgs, ...}:
{
  home.packages = with pkgs; [
    wl-clipboard # clipboard on wayland
    rofi-wayland # program selector
    libnotify # notifications
    brightnessctl # change brightness
    grimblast # screenshots
  ];
}
