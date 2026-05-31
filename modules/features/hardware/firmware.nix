{
  den.aspects.firmware = {
    nixos = {
      hardware.enableAllFirmware = true;
      hardware.enableRedistributableFirmware = true;
    };
  };
}
