{
  description = "Haru02w's config";

  outputs = { self, nixpkgs, home-manager, hyprland, ... } @ inputs: 
  let
    user = "haru02w";
    hostnames = ["vm" "zephyrus" "acme"];
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    nixosConfig = hostname: 
      nixpkgs.lib.nixosSystem {
        inherit system;
	modules = [ ./system/hosts/${hostname}/configuration.nix ];
      };
  in{
    nixosConfigurations = nixpkgs.lib.attrsets.genAttrs hostnames nixosConfig;

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ 
        hyprland.homeManagerModules.default
        ./user/${user}/home.nix
      ];
    };
  };


  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

  };
}
