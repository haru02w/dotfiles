{ pkgs, ... }: {
  home.packages = with pkgs; [
    swaylock
    wl-clipboard # clipboard on wayland
    libnotify # notifications
    brightnessctl # change brightness
    grimblast # screenshots
  ];
}
