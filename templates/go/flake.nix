{
  description = "Haru02w's template for dirty Go projects";

  # Use nixos-unstable for up-to-date Rust packages
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {nixpkgs, ...}: let
    inherit (nixpkgs) lib;
    # Get all supported systems from nixpkgs
    supportedSystems = lib.systems.flakeExposed;

    forEachSystem = f:
      lib.genAttrs supportedSystems (system: f pkgsFor.${system});

    pkgsFor = lib.genAttrs supportedSystems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = _: true;
      });
  in {
    # Provide some binary packages for selected system types.
    packages = forEachSystem (pkgs:
      with pkgs; {
        default = pkgs.buildGoModule {
          pname = "main";
          version = "0.0.1";
          src = ./.;
          subPackages = [ "src/main" ];
          vendorHash = null; 
        };
      });

    # Add a development shell with Rust tooling
    devShells = forEachSystem (pkgs:
      with pkgs; {
        default = mkShell {
          buildInputs = [
          ];
        };
      });
  };
}
