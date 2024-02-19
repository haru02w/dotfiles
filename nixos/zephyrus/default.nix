{ inputs, ... }: {
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
    ./laptop.nix
    ./nvidia.nix
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
    (import ./disko.nix { device = "/dev/nvme0n1"; })
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  services.tailscale.enable = true;

  #ignore lid close
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
  '';

  networking.hostName = "zephyrus";
}
