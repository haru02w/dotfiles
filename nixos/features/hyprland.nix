{pkgs, inputs, ...}:
{
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  programs.hyprland = {
    enable = true;
	  xwayland.enable = true;
	  portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  xdg.portal.enable = true;
  security.pam.services.swaylock = {};
}
