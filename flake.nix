{
  description = "NixOS configuration for ALL my machines.";
  outputs = { self, nixpkgs, ... }@inputs:
  let
    # Get all directories inside "./hosts" directory
    lib = nixpkgs.lib;
    hosts = builtins.attrNames (lib.filterAttrs (name: value: value == "directory") (builtins.readDir ./hosts));
  in {
    nixosConfigurations = builtins.listToAttrs (map (host: lib.nameValuePair host (lib.nixosSystem {
      modules = [ 
        self.outputs.nixosModules
        ./hosts/${host}/nixos
     ];
     specialArgs = { inherit inputs; };
    })) hosts);
    nixosModules = import ./modules/nixos;
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };
}
