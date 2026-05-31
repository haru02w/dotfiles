{
  den.aspects.grub.nixos = {
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
    };

    boot.loader.efi.canTouchEfiVariables = false;
  };
}
