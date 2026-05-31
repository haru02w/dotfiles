{ inputs, ... }:
{
  flake-file.inputs.vieb-nix = {
    url = "github:tejing1/vieb-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.vieb.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ (inputs.vieb-nix.packagesFunc pkgs).vieb ];
    };
}
