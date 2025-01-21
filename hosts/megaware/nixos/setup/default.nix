{
  config,
  pkgs,
  lib,
  ...
}: {
  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  # Networking
  networking.hostName = baseNameOf ./../..; # Define your hostname.
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Sops
  sops = {
    defaultSopsFile = lib.flakeRoot + "/secrets/secrets.yaml";
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/haru02w/.config/sops/age/keys.txt";
    secrets = {
      haru02w = {
        sopsFile = lib.flakeRoot + "/secrets/secrets.yaml";
        neededForUsers = true;
      };
      nextcloud = {
        owner = "nextcloud";
        group = "nextcloud";
        sopsFile = lib.flakeRoot + "/secrets/secrets.yaml";
      };
      "cloudflared/nas-tunnel" = {
        owner = "cloudflared";
        sopsFile = lib.flakeRoot + "/secrets/secrets.yaml";
      };
    };
  };

  # Users Requirements
  modules.home-manager.enable = true;
  programs.zsh.enable = true;

  # Users
  users.mutableUsers = false; # Disable imperative passwords
  users.users = let
    ifGroupsExist = groups:
      builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  in {
    root.hashedPasswordFile = "!"; # Disable root login
    haru02w = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.haru02w.path;
      shell = pkgs.zsh;
      extraGroups = ifGroupsExist [
        "wheel"
        "input"
        "video"
        "audio"
        "docker"
        "networkmanager"
        "lp"
        "libvirtd"
        "git"
        "kvm"
      ];
      packages = [
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
