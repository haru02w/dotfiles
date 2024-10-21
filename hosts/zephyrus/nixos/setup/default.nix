{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    (import ./disko.nix {device = "/dev/nvme0n1";})
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  system.stateVersion = "24.05";

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/disk/by-partlabel/disk-main-ROOT /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
      mkdir -p /btrfs_tmp/old_roots
      timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
      mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
      IFS=$'\n'
      for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
        delete_subvolume_recursively "/btrfs_tmp/$i"
      done
      btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
      delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.davfs2.enable = true;
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/home".neededForBoot = true;
  environment.nix-persist = {
    enable = true;
    path = "/persist";
  };

  #bluetooth support
  hardware.bluetooth.enable = true;

  hardware.nvidia = {
    open = false;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    dynamicBoost.enable = true;
  };
  services.asusd.enableUserService = true;

  environment.sessionVariables.AQ_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
  #:/etc/${
  #    config.environment.etc."nvicard".target
  #  }'';
  boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

  #ignore lid close
  services.logind.extraConfig = ''
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend
    HandleLidSwitchDocked=ignore
  '';
}
