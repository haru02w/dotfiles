{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.ssh;
in {
  options.modules.programs.ssh = {
    enable = mkEnableOption "ssh";
    enablePassword = mkEnableOption "Enable login with password ";
    enableRootLogin = mkEnableOption "Enable root login";
  };
  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        # Harden
        PasswordAuthentication = cfg.enablePassword;
        PermitRootLogin = (
          if cfg.enableRootLogin
          then "yes"
          else "no"
        );
        # Automatically remove stale sockets
        StreamLocalBindUnlink = "yes";
        # Allow forwarding ports to everywhere
        GatewayPorts = "clientspecified";
      };
    };
  };
}
