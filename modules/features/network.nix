{
  den.aspects.network.nixos =
    { lib, ... }:
    {
      networking = {
        useDHCP = lib.mkDefault true;
        networkmanager.enable = true;
        nameservers = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };

      hardware.bluetooth.enable = true;
    };
}
