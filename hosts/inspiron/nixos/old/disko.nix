{
  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "size=4G" "defaults" "mode=755" ];
    };
    disk.main = {
      device = "/dev/disk/by-id/ata-FUJITSU_MJA2160BH_G2_K95BT9926SR8";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "BOOT";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          swap = {
            size = "8G";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true;
            };
          };
          root = {
            name = "ROOT";
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/persist" = {
                  mountpoint = "/persist";
                  mountOptions = [ "subvol=persist" "compress=zstd" ];
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "subvol=nix" "compress=zstd" ];
                };
              };
            };
          };
        };
      };
    };
  };
}
