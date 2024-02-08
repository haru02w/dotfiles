{config,}:
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    grub = {
      efiSupport = true;
      #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
      #WARN: maybe wont work
      device = if !(config ? disko) then  "nodev" else "";
    };
  };
}
