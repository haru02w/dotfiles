{
  description = "NixOS configuration for ALL my machines.";
  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib // home-manager.lib;
    # Get all directories inside "./hosts" directory
    hosts = directoriesInsidePath ./hosts;

    # Get all supported systems by nixpkgs
    supportedSystems = lib.systems.flakeExposed;

    forEachSystem = f:
      lib.genAttrs supportedSystems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs supportedSystems (system:
      import nixpkgs {
        inherit system;
        overlays = builtins.attrValues inputs.self.outputs.overlays;
        config.allowUnfree = true;
        config.allowUnfreePredicate = _: true;
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

    nixvimModule = pkgs: {
      inherit pkgs;
      module = import ./modules/nixvim; # import the module directly
      # You can use `extraSpecialArgs` to pass additional arguments to your module files
      extraSpecialArgs = {
        # inherit (inputs) foo;
      };
    };
  in {
    nixosModules = import ./modules/nixos;
    homeModules = import ./modules/home-manager;

    # 'nix flake check`
    checks = forEachSystem (pkgs: {
      nixvim = with inputs.nixvim.lib.${pkgs.system};
        check.mkTestDerivationFromNixvimModule (nixvimModule pkgs);
    });
    # 'nix build', 'nix shell', etc
    packages = forEachSystem (pkgs:
      {
        nixvim = with inputs.nixvim.legacyPackages.${pkgs.system};
          makeNixvimWithModule (nixvimModule pkgs);
      }
      // (import ./pkgs {inherit pkgs inputs;}));
    overlays = import ./overlays {inherit inputs;};
    # 'nix develop'
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    # 'nix fmt'
    formatter = forEachSystem (pkgs: pkgs.alejandra);
    # 'nix flake new -t self#<template>'
    templates = import ./templates;

    # 'nixos-rebuild --flake .#<hostname>'
    nixosConfigurations = nixosConfigPerHost (host:
      lib.nixosSystem {
        pkgs = pkgsFor."${import ./hosts/${host}/arch.nix}";
        modules =
          [./hosts/${host}/nixos]
          ++ (builtins.attrValues self.outputs.nixosModules);
        specialArgs = {
          inherit inputs;
          homeUsers = homeManagerUsersPerHost host;
        };
      });

    # 'home-manager --flake .#<username>@<hostname>'
    homeConfigurations = homeManagerConfigPerHostAndUser (host: user:
      lib.homeManagerConfiguration {
        pkgs = pkgsFor."${import ./hosts/${host}/arch.nix}";
        modules = [
          inputs.stylix.homeManagerModules.stylix
          ./hosts/${host}/home-manager/${user}
        ];
        extraSpecialArgs = {inherit inputs;};
      });
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
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # hyprland = {
    #   type = "git";
    #   submodules = true;
    #   url = "https://github.com/hyprwm/Hyprland";
    #   ref = "refs/tags/v0.42.0";
    # };
    nixos-hardware.url = "github:nixos/nixos-hardware";
    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nur.url = "github:nix-community/nur";
  };

  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org" # hyprland
      "https://nix-community.cachix.org" # nix-community (nur)
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" # Hyprland
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" # nix-community (nur)
    ];
  };
}
