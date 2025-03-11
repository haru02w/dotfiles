{
  pkgs,
  lib,
  ...
}: {
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      # Harden
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
      # Allow forwarding ports to everywhere
      GatewayPorts = "clientspecified";
    };
  };
}
