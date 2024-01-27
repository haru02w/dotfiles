{ lib, config, pkgs, ... }:
with lib;
let cfg = config.hardware.laptop;
in {
  options.hardware.laptop = {
    enable = mkEnableOption "Laptop features";
    wifi = {
      enable = mkOption {
        type = types.bool;
        default = true;
        example = false;
      };
      enableOpenvpn = mkEnableOption "OpenVPN module";
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

  config = {
    networking.networkmanager = mkIf cfg.wifi.enable {
      enable = true;
      plugins = lib.optional cfg.wifi.enableOpenvpn pkgs.networkmanager-openvpn;
    };
    hardware.bluetooth.enable = mkIf cfg.bluetooth.enable true;
    programs.light.enable = mkIf cfg.backlight.enable true;

    environment.systemPackages = lib.optional cfg.wifi.enableOpenvpn pkgs.openvpn;
  };
  /* config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.wifi.enable { networking.networkmanager.enable = true; })

    (mkIf cfg.bluetooth.enable { hardware.bluetooth.enable = true; })

    (mkIf cfg.backlight.enable { programs.light.enable = true; })
  ]); */
}
