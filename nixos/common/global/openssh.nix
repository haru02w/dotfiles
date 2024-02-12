{ config, lib, ... }:
let hasImpermanence = config.environment.persistence ? "/persist";
in {
  services.openssh = {
    enable = true;
    hostKeys = [{
      path = "${
          lib.optionalString hasImpermanence "/persist"
        }/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }];
    settings = {
      # Harden
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
      # Allow forwarding ports to everywhere
      GatewayPorts = "clientspecified";
    };
  };
}
