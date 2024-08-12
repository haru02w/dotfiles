{ lib, config, ... }:
with lib;
let cfg = config.modules.ssh;
in {
  options.modules.ssh = {
    enable = mkEnableOption "ssh";
    enablePassword = mkEnableOption "Enable login with password ";
    enableRootLogin = mkEnableOption "Enable root login";
  };
  config = mkIf cfg.enable {
    services.openssh = {
      enable = mkDefault true;
      settings = {
        # Harden
        PasswordAuthentication = mkDefault cfg.enablePassword;
        PermitRootLogin =
          mkDefault (if cfg.enableRootLogin then "yes" else "no");
        # Automatically remove stale sockets
        StreamLocalBindUnlink = mkDefault "yes";
        # Allow forwarding ports to everywhere
        GatewayPorts = mkDefault "clientspecified";
      };
    };
  };
}
