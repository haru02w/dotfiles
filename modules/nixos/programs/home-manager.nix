{
  lib,
  config,
  inputs,
  homeUsers,
  ...
}:
with lib; let
  cfg = config.modules.home-manager;
in {
  options.modules.home-manager.enable = mkEnableOption "home-manager";
  config = mkIf cfg.enable {
    home-manager = {
      users = lib.genAttrs homeUsers (user:
        import
        ../../../hosts/${config.networking.hostName}/home-manager/${user});
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
    };
  };
}
