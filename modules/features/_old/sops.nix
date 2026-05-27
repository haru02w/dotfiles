{ den, ... }:
{
  flake-file.inputs.sops-nix.url = "github:Mic92/sops-nix";

  den.aspects.sops = {
    nixos =
      {
        config,
        lib,
        inputs,
        ...
      }:
      {
        imports = [ inputs.sops-nix.nixosModules.sops ];

        sops = {
          defaultSopsFile = lib.flakeRoot + "/secrets/secrets.yaml";
          defaultSopsFormat = "yaml";
          age.keyFile = "${config.users.users.haru02w.home}/.config/sops/age/keys.txt";
          secrets.haru02w = {
            sopsFile = lib.flakeRoot + "/secrets/secrets.yaml";
            neededForUsers = true;
          };
        };
      };

    homeManager =
      {
        config,
        lib,
        inputs,
        ...
      }:
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        sops = {
          defaultSopsFile = lib.flakeRoot + "/secrets/secrets.yaml";
          defaultSopsFormat = "yaml";
          age.keyFile = lib.mkDefault "/${config.home.homeDirectory}/.config/sops/age/keys.txt";

          secrets = {
            "ssh/key" = {
              sopsFile = lib.flakeRoot + "/secrets/secrets.yaml";
              path = "${config.home.homeDirectory}/.ssh/id_ed25519";
            };
            "ssh/pub" = {
              sopsFile = lib.flakeRoot + "/secrets/secrets.yaml";
              path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
            };
            "openrouter-apikey" = {
              sopsFile = lib.flakeRoot + "/secrets/secrets.yaml";
              path = "${config.home.homeDirectory}/.config/openrouter-api.key";
            };
          };
        };
      };
  };
}
