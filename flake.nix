{
  description = "My dotfiles";
  outputs = inputs: let
    lib = import ./lib {inherit inputs;};
  in {
    inherit lib;
    nixosModules = {
      modules = _: {
        imports = lib.nixFilesInPathR ./modules/nixos;
      };
    };
    homeModules = {
      modules = _: {
        imports = lib.nixFilesInPathR ./modules/home-manager;
      };
    };
    nixvimModule = import ./modules/nixvim;

    # 'nixos-rebuild --flake .#<hostname>'
    nixosConfigurations = lib.mkNixosConfig (host: let
      settings = import ./hosts/${host} {};
    in {
      pkgs = lib.pkgsFor."${settings.arch}";
      modules =
        lib.nixFilesInPathR ./hosts/${host}/nixos
        ++ (builtins.attrValues inputs.self.outputs.nixosModules);
      specialArgs = {
        inherit lib;
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
          inputs.stylix.homeModules.stylix
        ];
      extraSpecialArgs = {
        inherit lib;
        inherit inputs;
        inherit settings;
      };
    });

    # 'nix build', 'nix shell', etc
    packages = lib.forEachSystemPkgs (pkgs: import ./pkgs {inherit inputs pkgs;});
    overlays = import ./overlays {inherit inputs;};
    # 'nix develop'
    devShells = lib.forEachSystemPkgs (pkgs: import ./shell.nix {inherit inputs pkgs;});
    # 'nix fmt'
    formatter = lib.forEachSystemPkgs (pkgs: pkgs.alejandra);
    # 'nix flake new -t self#<template>'
    templates = lib.mkTemplates;
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos-cuda.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" # nix-community (nur)
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" # Cuda
    ];
  };

  inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tmux-toggle-scratch = {
      url = "github:momo-lab/tmux-toggle-scratch";
      flake = false;
    };
  };
}
