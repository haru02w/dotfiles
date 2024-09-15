{ config, pkgs, ... }: {
  imports = [ ./setup ];

  networking.hostName = "testvm";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "compose:ralt";

  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
  ];

  services.openssh.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" "repl-flake" ];

  ### --- HARU02W --- ###
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/haru02w/.config/sops/age/keys.txt";
    secrets.haru02w = {
      sopsFile = ../../../secrets/secrets.yaml;
      neededForUsers = true;
    };
  };
  users.mutableUsers = false; # disable imperative passwords
  users.users = {
    root.hashedPasswordFile = "!"; # disable root login
    haru02w = {
      isNormalUser = true;
      # initialPassword = "2003";
      hashedPasswordFile = config.sops.secrets.haru02w.path;
      extraGroups = [ "wheel" "video" "audio" ];
      packages = with pkgs; [ firefox tree ];
    };
  };
  ### ---         --- ###
}
