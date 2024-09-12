{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.profile;
  directoriesInsidePath = path:
    builtins.attrNames (lib.filterAttrs (name: value: value == "directory")
      (builtins.readDir path));
in {
  options.modules.profile = mkOption {
    description = "Select a profile to apply";
    type = with types;
      enum (directoriesInsidePath ../../profiles ++ ["none"]);
    default = "none";
  };
  config = mkIf (cfg != "none") {imports = [../../profiles/${cfg}/nixos];};
}
