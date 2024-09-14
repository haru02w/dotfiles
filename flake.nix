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
          overlays = inputs.self.outputs.overlays;
          config.allowUnfree = true;
        });
      directoriesInsidePath = path:
        builtins.attrNames (lib.filterAttrs (name: value: value == "directory")
          (builtins.readDir path));
      homeManagerUsersPerHost = host:
        directoriesInsidePath ./hosts/${host}/home-manager;
      homeManagerConfigPerHostAndUser = systemPerHostAndUser:
        builtins.listToAttrs (lib.flatten (map (host:
          map (user:
            lib.nameValuePair "${user}@${host}"
            (systemPerHostAndUser host user)) (homeManagerUsersPerHost host))
          hosts));
      nixosConfigPerHost = systemPerHost:
        builtins.listToAttrs
        (map (host: lib.nameValuePair host (systemPerHost host)) hosts);
    in {
      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeModules = import ./modules/home-manager;

      nixosConfigurations = nixosConfigPerHost (host:
        lib.nixosSystem {
          modules = [ ./hosts/${host}/nixos ]
            ++ (builtins.attrValues self.outputs.nixosModules);
          specialArgs = {
            inherit inputs;
            homeUsers = homeManagerUsersPerHost host;
          };
        });
      homeConfigurations = homeManagerConfigPerHostAndUser (host: user:
        lib.homeManagerConfiguration {
          pkgs = pkgsFor."${import ./hosts/${host}/arch.nix}";
          modules = [
            inputs.stylix.homeManagerModules.stylix
            ./hosts/${host}/home-manager/${user}
          ] ++ (builtins.attrValues self.outputs.homeModules);
          extraSpecialArgs = { inherit inputs; };
        });

      formatter = forEachSystem (pkgs: pkgs.alejandra);
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    nix-persist = {
      url = "github:haru02w/nix-persist";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # TODO:
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };
    nur.url = "github:nix-community/NUR";
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org" # nix-community (nur)
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" # nix-community (nur)
    ];
  };
}
