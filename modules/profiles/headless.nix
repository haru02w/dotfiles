{ den, ... }:
{
  den.aspects.headless = {
    includes = [
      den.aspects.base
      den.aspects.git
      den.aspects.zsh
      den.aspects.starship
      den.aspects.direnv
      den.aspects.docker
      den.aspects.openssh
      den.aspects.nix-ld
      den.aspects.stylix
      den.aspects.nvf
      den.aspects.tmux
      den.aspects.rbw
    ];

    nixos = _: { };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          btop
          libqalculate
          tldr
          zip
          unzip
          p7zip
        ];
      };
  };
}
