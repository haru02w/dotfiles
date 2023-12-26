{
  description = "Python project template";

  outputs = {self, nixpkgs, ...} @ inputs:
  let
    forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
    pkgsFor = nixpkgs.legacyPackages;
  in
  {
    devShells = forAllSystems (system:{
      default = pkgsFor.${system}.callPackage ./shell.nix { };
    });
  };

  inputs = { 
	  nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };
}
