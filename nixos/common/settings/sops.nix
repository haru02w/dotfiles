{ lib, config, ... }:
let
  # WARN: put private key at this location
  privateKey =
    "${lib.optionalString hasImpermanence "/persist"}/etc/sops/age/keys.txt";
  hasImpermanence = config.environment.persistence ? "/persist";
in {
  sops = {
    defaultSopsFile = ../../secrets/accounts.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = privateKey;
  };
}
