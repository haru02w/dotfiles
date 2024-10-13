{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  system.stateVersion = "24.05";

  fileSystems."/var/lib/nextcloud" = {
    device = "/dev/disk/by-uuid/2f606808-3cab-4c09-bd24-dd2624c92c51";
    fsType = "btrfs";
    options = ["auto" "nofail"];
  };

  #ignore lid close
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
    HandleLidSwitchDocked=ignore
  '';
}
