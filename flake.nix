{
  description = "NixOS configuration for ALL my machines.";
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    lib = nixpkgs.lib // home-manager.lib;
    # Get all directories inside "./hosts" directory
    hosts = directoriesInsidePath ./hosts;
    # Get all supported systems by nixpkgs
    suportedSystems = lib.systems.flakeExposed;

    forEachSystem = f:
      lib.genAttrs suportedSystems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs suportedSystems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      }
    );
    directoriesInsidePath = path : builtins.attrNames (lib.filterAttrs (name: value: value == "directory") (builtins.readDir path));
    homeManagerUsersPerHost = host: directoriesInsidePath ./hosts/${host}/home-manager;
    homeManagerConfigPerHostAndUser = systemPerHostAndUser: builtins.listToAttrs (map (host: map (user: lib.nameValuePair "${user}@${host}" (systemPerHostAndUser host user)) (homeManagerUsersPerHost host)) hosts);
    nixosConfigPerHost = systemPerHost: builtins.listToAttrs (map (host: lib.nameValuePair host (systemPerHost host)) hosts);
  in {
    nixosConfigurations = nixosConfigPerHost (host: lib.nixosSystem {
      modules = [ 
        self.outputs.nixosModules
        ./hosts/${host}/nixos
     ];
     specialArgs = { inherit inputs; };
    });

    homeConfigurations = homeManagerConfigPerHostAndUser (host: user: lib.homeManagerConfiguration {
      pkgs = import ./hosts/${host}/pkgs.nix pkgsFor;
      extraSpecialArgs = { inherit inputs; };
    });

    nixosModules = import ./modules/nixos;
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
