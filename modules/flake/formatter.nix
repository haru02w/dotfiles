{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  flake-file.inputs.treefmt-nix = {
    url = "github:numtide/treefmt-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem.treefmt = {
    programs = {
      nixfmt.enable = true;
      nixfmt.excludes = [ ".direnv" ];
    };
  };
}
