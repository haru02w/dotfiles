{
  # wifi support
  networking.networkmanager = {
    enable = true;
    # plugins = pkgs.networkmanager-openvpn;
  };

  # monitor backlight
  programs.light.enable = true;

  #bluetooth support
  hardware.bluetooth.enable = true;
}
