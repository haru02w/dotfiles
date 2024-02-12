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
    (import ./disko.nix { device = "/dev/vda"; })
  ];

  # bootloader
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  
  # services
  networking.networkmanager.enable = true;
  services.openssh.enable = true;

  # extra configuration
  networking.hostName = "testvm";
}
