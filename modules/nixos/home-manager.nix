{
  lib,
  config,
  inputs,
  settings,
  ...
}:
with lib; let
  cfg = config.modules.home-manager;
in {
  options.modules.home-manager.enable = mkEnableOption "home-manager";
  config = mkIf cfg.enable {
    home-manager = let
      host = config.networking.hostName;
    in {
      users = lib.genAttrs (mkHomeUsers host) (user: _: {
        imports = nixFilesInPathR (flakeRoot + "/hosts/${host}/home-manager/${user}");
      });
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-backup";
      extraSpecialArgs = {
        inherit lib;
        inherit inputs;
        inherit settings;
      };
    };
  };
}
