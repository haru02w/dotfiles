{ #Enable automounting in /run/media/$USER/
  # OBS: It needs the following option at nixos config
  # 'services.udisks2.enable = true'
  services.udiskie = {
    enable = true;
    tray = "auto";
    notify = true;
    automount = true;
    settings = {
      device_config = [
        {
          id_label = "VTOYEFI";
          ignore = true;
        }
      ];
    };
  };
}
