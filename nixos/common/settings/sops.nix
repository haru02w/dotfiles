{ lib, config, ... }:
# WARN: put private key at this location
let
  hasImpermanence = config.environment.persistence ? "/persist";
  privateKey =
    "${lib.optionalString hasImpermanence "/persist"}/etc/sops/age/keys.txt";
in {
  sops = {
    defaultSopsFile = ../../secrets/accounts.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = privateKey;
  };
}
