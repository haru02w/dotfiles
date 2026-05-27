{
  den.aspects.openssh.nixos.services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
      StreamLocalBindUnlink = "yes";
      GatewayPorts = "clientspecified";
    };
  };
}
