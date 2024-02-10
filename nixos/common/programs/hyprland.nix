{
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
  };

  xdg.portal.enable = true;

  security.pam.services.swaylock = { };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
