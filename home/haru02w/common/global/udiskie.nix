{ # Enable automounting in /run/media/$USER/
  # OBS: The following option at nixos config must be enabled
  # 'services.udisks2.enable = true'
  services.udiskie = {
    enable = true;
    tray = "auto";
    notify = true;
    automount = true;
    settings = {
      device_config = [{
        id_label = "VTOYEFI";
        ignore = true;
      }];
    };
  };
}
