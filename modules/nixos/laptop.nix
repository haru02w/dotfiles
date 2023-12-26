{lib, config, ...}:
with lib;
let
  cfg = config.hardware.laptop;
in
{
  options.hardware.laptop = {
	enable = mkEnableOption "Laptop features";
	wifi = {
	  enable = mkOption {
		type = types.bool;
		default = true;
		example = false;
	  };
	};

	bluetooth = {
	  enable = mkOption {
		type = types.bool;
		default = true;
		example = false;
	  };
	};

	backlight = {
	  enable = mkOption {
		type = types.bool;
		default = true;
		example = false;
	  };
	};
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.wifi.enable {
      networking.networkmanager.enable = true;
	})

    (mkIf cfg.bluetooth.enable {
	  hardware.bluetooth.enable = true;
	})

	(mkIf cfg.backlight.enable {
	  programs.light.enable = true;
	})
  ]);
}
