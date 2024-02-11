# WARN: put private key at this location
let
  privateKey = "/etc/sops/age/keys.txt";
in {
  sops = {
    defaultSopsFile = ../../secrets/accounts.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = privateKey;
  };
}
