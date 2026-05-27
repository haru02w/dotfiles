{den, ...}: {
  den.aspects.zephyrus.includes = [den.aspects.kvm-amd];
  den.aspects.zephyrus.nixos = {
    config,
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod"];
  };
}
