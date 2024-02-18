{ pkgs, ... }: {
  imports = [ ./firefox.nix ];
  home.packages = with pkgs; [
    (symlinkJoin {
      name = "vieb";
      paths = [ vieb ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/vieb --add-flags \
        "--enable-features=UseOzonePlatform --ozone-platform=wayland"
      '';
    })
    discord
    webcord
  ];
}
