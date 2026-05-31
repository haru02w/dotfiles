{ inputs, ... }:
let
  secretsFile = inputs.self + "/secrets/secrets.yaml";
in
{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.sops = {
    nixos =
      { config, ... }:
      {
        imports = [ inputs.sops-nix.nixosModules.sops ];

        sops = {
          defaultSopsFile = secretsFile;
          defaultSopsFormat = "yaml";
          age.keyFile = "${config.users.users.haru02w.home}/.config/sops/age/keys.txt";
          secrets.haru02w = {
            neededForUsers = true;
          };
        };

        users.mutableUsers = false;
        users.users.haru02w.hashedPasswordFile = config.sops.secrets.haru02w.path;
      };

    homeManager =
      {
        config,
        lib,
        ...
      }:
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        sops = {
          defaultSopsFile = secretsFile;
          defaultSopsFormat = "yaml";
          age.keyFile = lib.mkDefault "${config.home.homeDirectory}/.config/sops/age/keys.txt";

          secrets = {
            "ssh/key".path = "${config.home.homeDirectory}/.ssh/id_ed25519";
            "ssh/pub".path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
            "openrouter-apikey".path = "${config.home.homeDirectory}/.config/openrouter-api.key";
          };
        };
      };
  };
}
