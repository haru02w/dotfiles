{ den, ... }:
{
  den.aspects.cli-packages.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        rclone
        lazygit
        progress
        libqalculate
        ncdu
        btop
        fastfetch
        tldr
        zip
        unzip
        devenv
        yazi
      ];
      home.sessionVariables.EDITOR = "nvim";
    };
}
