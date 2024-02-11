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
    ./disko.nix
  ];
  boot.loader.grub.device = "/dev/vda";

  networking.networkmanager.enable = true;
  services.tailscale.enable = true;

  #ignore lid close
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
  '';

  networking.hostName = "zephyrus";
  services.openssh.enable = true;
}
