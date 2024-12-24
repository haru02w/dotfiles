{
  pkgs,
  lib,
  ...
}: {
  # Stylix
  stylix = {
    enable = true;

    image = lib.flakeRoot + "/wallpapers/localhost.jpg";
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark-terminal.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Mono";
      };

      sansSerif = {
        package = pkgs.open-sans;
        name = "Open Sans";
      };

      serif = {
        package = pkgs.roboto-serif;
        name = "Roboto Serif";
      };

      sizes = {
        desktop = 12;
        popups = 10;
        terminal = 14;
        applications = 12;
      };
    };
  };
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Tuigreet
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --user-menu \
          --remember \
          --remember-user-session \
          --asterisks \
          --window-padding 1 \
          --container-padding 2 \
          --prompt-padding 2 \
          --cmd "sway"
        '';
        user = "greeter";
      };
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      # Harden
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
      # Allow forwarding ports to everywhere
      GatewayPorts = "clientspecified";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Auto-mount disks
  services.udisks2.enable = true;

  # Access for private devices (VPN)
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  # Enable Docker with docker-compose
  virtualisation.docker = {
    enable = true;
    extraPackages = [pkgs.docker-compose];
  };

  # Virt-manager service to run virtual machines
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
