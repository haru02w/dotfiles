{
  description = "DevShell template";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    inherit (nixpkgs) lib;
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
    devShells = forEachSystem (pkgs: {
      default = lib.mkShell {
        # buildInputs - Dependencies that should exist in the runtime environment.
        # propagatedBuildInputs - Dependencies that should exist in the runtime environment and also propagated to downstream runtime environments.
        # nativeBuildInputs - Dependencies that should only exist in the build environment.
        # propagatedNativeBuildInputs - Dependencies that should only exist in the build environment and also propagated to downstream build environments.
        builInputs = with pkgs;[devenv];
      };
    });
  };
}
