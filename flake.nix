{
  description = "Haru02w's config";

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: 
  let
    hostnames = ["vm"];
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

    homeConfigurations."haru02w" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./user/haru02w/home.nix ];
    };
  };


  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
