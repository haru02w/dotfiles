{...}: {
  imports = [(import ./disko.nix {device = "/dev/sda";})];
  fileSystems."/persist".neededForBoot = true;
  programs.fuse.userAllowOther = true;

  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      #...
    ];
  };
}
