{ device ? throw "Set this to your disk device, e.g. /dev/sda", ... }: {
  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "size=4G" "defaults" "mode=755" ];
    };
    disk.main = {
      inherit device;
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
                "/swap" = {
                  mountpoint = "/.swapvol";
                  swap.swapfile.size = "8G";
                };
              };
            };
          };
        };
      };
    };
  };
}
