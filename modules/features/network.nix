{
  den.aspects.network.nixos = {lib, ...}: {
    networking = {
      useDHCP = lib.mkDefault true;
      networkmanager.enable = true;
    };

    hardware.bluetooth.enable = true;
  };
}
