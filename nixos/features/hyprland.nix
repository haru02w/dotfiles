{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  xdg.portal.enable = true;
  security.pam.services.swaylock = { };
}
