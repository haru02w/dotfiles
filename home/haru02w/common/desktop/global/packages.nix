{ pkgs, ... }:
{
  home.packages = with pkgs;[
    discord
    webcord
    gimp
    (symlinkJoin {
      # vieb pached for wayland
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
