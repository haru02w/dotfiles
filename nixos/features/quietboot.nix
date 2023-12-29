{
  console.earlySetup = false;
  boot = {
    plymouth.enable = true;
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      # "udev.log_level=3"
      "rd.udev.log_level=3"
      # "vt.global_cursor_default=0"
    ];
  };
}
