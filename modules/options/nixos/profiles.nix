{ lib, config, ... }:
with lib;
let
  cfg = config.modules.profile;
  directoriesInsidePath = path:
    builtins.attrNames (lib.filterAttrs (name: value: value == "directory")
      (builtins.readDir path));
in {
  options.modules.profile = mkOption {
    description = "Select a profile to apply";
    type = with types;
      nullOr (enum (directoriesInsidePath ../../profiles));
    default = null;
  };
  config =
    mkIf (cfg != null) { imports = [ ../../profiles/${cfg}/home-manager ]; };
}
