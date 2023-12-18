{ config, lib, pkgs, ...}:

{
  /* environment.systemPackages = with pkgs; [
    waybar
    mako
    libnotify
    kitty # allacritty later
    alacritty
    rofi-wayland
  ]; */

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
  };

  # Enable pipewire
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

}
