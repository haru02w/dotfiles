{ inputs, outputs, ... }: {
  imports = (builtins.attrValues outputs.nixosModules) ++ [
    ./hardware-configuration.nix
    ./disko.nix
    ../common/bootloader/uefi_systemd-boot.nix
    ../common/global
    ../common/sops.nix
    ../common/users/haru02w.nix
    ./laptop.nix
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];
  services.tailscale.enable = true;

  #ignore lid close
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
  '';

  networking.hostName = "zephyrus";
}
