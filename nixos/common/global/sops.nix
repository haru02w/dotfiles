{ inputs, config, lib, ... }:
let hasOptinPersistence = config.environment.persistence ? "/persist";
in {
  imports = [ inputs.sops-nix.nixosModules.sops ];
  sops.age.keyFile = "${
      lib.optionalString hasOptinPersistence "/persist"
    }/etc/sops/age/keys.txt";
}
