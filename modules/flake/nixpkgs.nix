{ inputs, ... }:
let
  config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
    allowBroken = false;
  };
in
{
  flake-file.inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  den.default = {
    nixos.nixpkgs = { inherit config; };
    homeManager.nixpkgs = { inherit config; };
  };

  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system config;
      };
    };
}
