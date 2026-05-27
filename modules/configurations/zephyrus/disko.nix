{inputs, ...}: {
  flake-file.inputs.disko.url = "github:nix-community/disko";

  den.aspects.zephyrus.nixos = {lib, ...}: {
    imports = [inputs.disko.nixosModules.disko];

    virtualisation.vmVariant = {
      swapDevices = lib.mkForce [];
      boot.resumeDevice = lib.mkForce "";
    };

    disko.devices.disk.main = {
      device = "/dev/nvme0n1";
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
            size = "155G";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];
              subvolumes = {
                "/" = {
                  mountpoint = "/";
                  mountOptions = ["compress=zstd"];
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = ["compress=zstd"];
                };
              };
            };
          };
        };
      };
    };
  };
}
