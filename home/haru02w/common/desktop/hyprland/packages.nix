{pkgs, ...}:
{
  home.packages = with pkgs; [
    wl-clipboard # clipboard on wayland
    libnotify # notifications
    brightnessctl # change brightness
    grimblast # screenshots
  ];
}
