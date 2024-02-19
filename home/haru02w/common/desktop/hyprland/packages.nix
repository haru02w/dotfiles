{ pkgs, ... }: {
  home.packages = with pkgs; [
    wl-clipboard # clipboard on wayland
    libnotify # notifications
    brightnessctl # change brightness
    grimblast # screenshots
    (symlinkJoin { # vieb pached for wayland
      name = "vieb";
      paths = [ vieb ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/vieb --add-flags \
        "--enable-features=UseOzonePlatform --ozone-platform=wayland"
      '';
    })
  ];
}
