{
  description = "Python project template";

  outputs = { self, nixpkgs, ... }:
    let
      forAllSystems = function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ] (system:
          function (import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            # config.cudaSupport = true; # Toggle to install cuda-tools
            # overlays = [];
          }));
    in {
      packages = forAllSystems (pkgs: {
        default = pkgs.callPackage ./package.nix { };
        # cuda = pkgs.callPackage ./cuda-package.nix { };
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.callPackage ./shell.nix { };
        package = self.outputs.packages.${pkgs.system}.default;
        cuda = pkgs.callPackage ./shell.nix { };
      });
    };

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11"; };
}
