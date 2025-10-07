{
  description = "Template for dirty Python projects with UV package manager";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {nixpkgs, ...}: let
    inherit (nixpkgs) lib;
    supportedSystems = lib.systems.flakeExposed;

    forEachSystem = f: lib.genAttrs supportedSystems (system: f pkgsFor.${system});

    pkgsFor = lib.genAttrs supportedSystems (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.allowUnfreePredicate = _: true;
        }
    );
  in {
    # Provide a Python package build using uv
    packages = forEachSystem (pkgs: {
      # TODO: It's not really working yet, idk why
      default = pkgs.python3Packages.buildPythonApplication {
        pname = "main";
        version = "0.1.0";
        src = ./.;
        format = "pyproject";
      };
    });

    # Development shell with uv and Python tooling
    devShells = forEachSystem (
      pkgs:
        with pkgs; {
          default = mkShell {
            buildInputs = [
              python3
              uv
            ];
          };
        }
    );
  };
}
