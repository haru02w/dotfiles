{
  imports = [
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
  ];

  networking.networkmanager.enable = true;

  networking.hostName = "testvm";
  services.openssh.enable = true;
}
