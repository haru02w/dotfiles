{
  description = "Python project with cuda tools template";

  outputs = {self, nixpkgs, ...} @ inputs:
  let
    forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
    # pkgsFor = nixpkgs.legacyPackages;
  in
  {
    devShells = forAllSystems (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          cudaSupport = true;
        };
      };
    in
    {
      default = pkgs.callPackage ./shell.nix { };
    });
  };

  inputs = { 
	  nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };
}
