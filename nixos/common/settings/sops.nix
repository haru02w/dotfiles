{ config, lib, ... }:
# WARN: put private key at this location
let
  privateKey = ''
    ${lib.optionalString
      (config.environment.persistence ? "/persist")
      "/persist"
    }/etc/sops/age/keys.txt
  '';
in {
  sops = {
    defaultSopsFile = ../../secrets/accounts.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = privateKey;
  };
}
