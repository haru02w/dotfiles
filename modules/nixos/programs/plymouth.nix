{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.programs.plymouth;
in {
  options.modules.programs.plymouth.enable = mkEnableOption "plymouth";
  config = mkIf cfg.enable {
    boot = {
      plymouth.enable = true;

      # Enable "Silent Boot"
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
    };
  };
}
