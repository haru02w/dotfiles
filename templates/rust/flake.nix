{
  description = "Rust Template Project";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = f:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ] (system:
          f (import nixpkgs {
            inherit system;
            # config.allowUnfree = true;
            # overlays = [];
          }));
    in {
      packages =
        forAllSystems (pkgs: { default = pkgs.callPackage ./default.nix { }; });

      devShells =
        forAllSystems (pkgs: { default = pkgs.callPackage ./shell.nix { }; });
    };
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11"; };
}
