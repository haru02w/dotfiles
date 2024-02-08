{inputs, outputs, ...}:{
  imports = [
    (builtins.attrValues outputs.nixosModules)
    ./hardware-configuration.nix
    ./disko.nix
    ../common/bootloader/uefi_systemd-boot.nix
    ../common/global
    ./laptop.nix
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  networking.hostName = "zephyrus";

  #ignore lid close
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
  '';
}
