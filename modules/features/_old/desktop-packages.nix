{ den, ... }:
{
  den.aspects.desktop-packages.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        wl-clipboard
        libnotify
        brightnessctl
        sway-contrib.grimshot
        pulsemixer
        imv
      ];
    };
}
