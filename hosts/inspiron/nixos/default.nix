# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
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

  networking.hostName = "inspiron"; # Define your hostname.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true; # use xkb.options in tty.
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "compose:ralt";

  services.printing.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  users.users.haru02w = {
    isNormalUser = true;
    initialPassword = "2003";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ firefox ];
  };

  environment.systemPackages = with pkgs; [ neovim wget ];
  services.openssh.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" "repl-flake" ];
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "24.05"; # Did you read the comment?

}
