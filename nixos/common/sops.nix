{ inputs, ... }:
let privateKey = "/etc/sops/age/keys.txt";
in {
  imports = [ inputs.sops-nix.nixosModules.sops ];
  sops = {
    defaultSopsFile = ../../secrets/accounts.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = privateKey;
  };
}
