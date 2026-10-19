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
  };
}
