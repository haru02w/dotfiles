{ pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    (import ./disko.nix { device = "/dev/sda"; })
  ];

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

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  modules.settings = {
    hostname = "inspiron";
    keymap.layout = "us";
    locale = "en_US.UTF-8";
    timezone = "America/Sao_Paulo";
  };

  services.printing.enable = true;
  modules.programs.pipewire.enable = true;
  modules.displayManager.sddm.enable = true;
  modules.desktopEnvironment.plasma.enable = true;
  modules.fhsHelpers.enable = true;
  modules.programs.ssh = {
    enable = true;
    enablePassword = true;
    enableRootLogin = true;
  };

  environment.systemPackages = with pkgs; [ git neovim firefox home-manager ];

  users.users.haru02w = {
    isNormalUser = true;
    description = "haru02w";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "24.11";
}
