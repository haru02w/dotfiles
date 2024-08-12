{ inputs, lib, config, host, ... }:
with lib;
let cfg = config.modules.home-manager;
in {
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  options.modules.home-manager = {
    enable = mkEnableOption "home-manager";
  };
  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = mkDefault true;
      useUserPackages = mkDefault true;
      extraSpecialArgs = mkDefault { inherit inputs host; };
    };
  };
}
