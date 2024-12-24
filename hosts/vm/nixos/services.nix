{pkgs, ...}: {
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

  # Enable Docker with docker-compose
  virtualisation.docker = {
    enable = true;
    extraPackages = [pkgs.docker-compose];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
