{ inputs, ... }: {
  imports =  [
    # settings
    ../common/global
    ../common/bootloader/uefi_systemd-boot.nix
    ../common/settings/locale_n_timezone.nix
    ../common/settings/sops.nix
    ../common/settings/impermanence.nix
    ../common/users/haru02w.nix

    #programs
    ../common/programs/hyprland.nix
    ../common/programs/pipewire.nix
    ../common/programs/tuigreet.nix
    ../common/programs/udisks2.nix

    # host specific
    ./hardware-configuration.nix
    ./disko.nix
    ./laptop.nix
    ./nvidia.nix
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
