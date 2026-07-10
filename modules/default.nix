{
  lib,
  den,
  ...
}:
{
  den = {
    # Defaults
    default = {
      nixos.system.stateVersion = "26.05";
      homeManager.home.stateVersion = "26.05";
      includes = [
        den.batteries.define-user
        den.batteries.hostname
        den.batteries.inputs'
        den.batteries.self'
      ];
    };

    # Schemas
    schema.user = {
      classes = lib.mkDefault [ "homeManager" ];
      includes = [ den.batteries.mutual-provider ];
    };

    # Hosts
    hosts = {
      x86_64-linux.zephyrus.users.haru02w = { };
      x86_64-linux."zephyrus-wsl".users.haru02w = { };
    };
  };
}
