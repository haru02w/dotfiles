{device ? throw "Set this to your disk device, e.g. /dev/sda", ...}: {
  disko.devices.disk.main = {
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
        swap = {
          name = "SWAP";
          size = "4G";
          content = {
            type = "swap";
            resumeDevice = true;
          };
        };
        root = {
          name = "ROOT";
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = ["-f"];
            subvolumes = {
              "/root" = {mountpoint = "/";};
              "/nix" = {
                mountpoint = "/nix";
                mountOptions = ["compress=zstd"];
              };
              "/home" = {
                mountpoint = "/home";
                mountOptions = ["compress=zstd"];
              };
              "/persist" = {
                mountpoint = "/persist";
                mountOptions = ["compress=zstd"];
              };
            };
          };
        };
      };
    };
  };
}
