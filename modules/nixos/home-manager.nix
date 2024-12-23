{
  lib,
  config,
  inputs,
  settings,
  ...
}:
with lib; let
  cfg = config.modules.programs.home-manager;
in {
  options.modules.home-manager.enable = mkEnableOption "home-manager";
  config = mkIf cfg.enable {
    home-manager = {
      users = lib.genAttrs (mkHomeUsers host) (user: nixFilesInPathR ../hosts/${host}/home-manager/${user});
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs; inherit settings;};
    };
  };
}
