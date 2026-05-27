{
  den.aspects.udiskie = {
    homeManager.services.udiskie = {
      enable = true;
      tray = "auto";
      notify = true;
      automount = true;
    };

    nixos.services.udisks2.enable = true;
  };
}
