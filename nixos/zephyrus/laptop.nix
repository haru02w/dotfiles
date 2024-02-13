{
  # wifi support
  networking.networkmanager = {
    enable = true;
    # plugins = pkgs.networkmanager-openvpn;
  };

  #bluetooth support
  hardware.bluetooth.enable = true;
}
