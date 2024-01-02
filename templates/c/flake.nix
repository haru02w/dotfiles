{
  description = "C project template";

  outputs = {self, nixpkgs, ...}:
  let
    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ] (system: function 
      (import nixpkgs {
        inherit system;
        # config.allowUnfree = true;
        # overlays = [];
      })
    );
  in {
    packages = forAllSystems (pkgs: {
      default = pkgs.callPackage ./package.nix {};
      gcc = pkgs.callPackage ./package.nix {stdenv = pkgs.gccStdenv;};
      clang = pkgs.callPackage ./package.nix {stdenv = pkgs.clangStdenv;};
    });

    devShells = forAllSystems (pkgs: {
      default = self.outputs.packages.${pkgs.system}.default;
    });
  };

  inputs = { 
	  nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };
}
