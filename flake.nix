{
  description = "My dotfiles";
  outputs = inputs: let
    lib = import ./lib {inherit inputs;};
  in {
    nixosModules = import ./modules/nixos;
    homeModules = import ./modules/home-manager;

    # 'nixos-rebuild --flake .#<hostname>'
    nixosConfigurations = lib.mkNixosConfig (host: let
      settings = import ./hosts/${host} {} ;
    in {
      pkgs = lib.pkgsFor."${settings.arch}";
      modules =
        lib.nixFilesInPathR ./hosts/${host}/nixos
        ++ (builtins.attrValues inputs.self.outputs.nixosModules);
      specialArgs = {
        inherit inputs;
        inherit settings;
      };
    });

    # 'home-manager --flake .#<username>@<hostname>'
    homeConfigurations = lib.mkHomeConfig (host: user: let
      settings =
        import ./hosts/${host} {};
    in {
      pkgs = lib.pkgsFor."${settings.arch}";
      modules =
        lib.nixFilesInPathR ./hosts/${host}/home-manager/${user}
        ++ [
          inputs.stylix.homeManagerModules.stylix
        ];
      extraSpecialArgs = {
        inherit inputs;
        inherit settings;
      };
    });

    # 'nix build', 'nix shell', etc
    packages = lib.forEachSystem (pkgs:
      {
        nixvim = lib.mkNixvimPkg pkgs;
      }
      // (import ./pkgs {inherit pkgs inputs;}));
    overlays = import ./overlays {inherit inputs;};
    # 'nix develop'
    devShells = lib.forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    # 'nix fmt'
    formatter = lib.forEachSystem (pkgs: pkgs.alejandra);
    # 'nix flake new -t self#<template>'
    templates = import ./templates;
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" # nix-community (nur)
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nur.url = "github:nix-community/nur";
  };
}
