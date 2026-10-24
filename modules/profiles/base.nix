{ den, ... }:
{
  den.aspects.base = {
    includes = [
      den.aspects.home-manager-self
      den.aspects.nix-settings
      den.aspects.nix-index
      den.aspects.network
      den.aspects.locale
      den.aspects.security
      den.aspects.sops
    ];

    nixos = _: {
      # `nh os switch` (run as the user, not under sudo)
      programs.nh = {
        enable = true;
        flake = "/home/haru02w/dotfiles";
      };
    };
    homeManager = _: { };
  };
}
