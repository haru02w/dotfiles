{
  imports = [
    # settings
    ../common/global
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
    (import ./disko.nix {device = "/dev/vda";})
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.networkmanager.enable = true;

  networking.hostName = "testvm";
  services.openssh.enable = true;
}
