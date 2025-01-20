{
  pkgs,
  config,
  ...
}: {
  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud30;
      https = true;
      configureRedis = true;
      database.createLocally = true;
      maxUploadSize = "16G";
      hostName = "nc.haru02w.eu.org";
      notify_push = {
        enable = true;
        bendDomainToLocalhost = true;
      };
      autoUpdateApps.enable = true;
      appstoreEnable = true;
      extraAppsEnable = true;
      extraApps = {
        inherit
          (config.services.nextcloud.package.packages.apps)
          deck
          notes
          contacts
          calendar
          onlyoffice
          bookmarks
          twofactor_webauthn
          previewgenerator
          ;
      };
      settings = {
        updatechecker = false;
        overwriteprotocol = "https";
        default_phone_region = "BR";
      };
      config = {
        dbtype = "pgsql";
        adminuser = "haru02w";
        adminpassFile = "${config.sops.secrets.nextcloud.path}";
      };
      poolSettings = {
        pm = "dynamic";
        "pm.max_children" = "105";
        "pm.max_requests" = "500";
        "pm.max_spare_servers" = "78";
        "pm.min_spare_servers" = "26";
        "pm.start_servers" = "26";
      };
    };
    onlyoffice = {
      enable = true;
      hostname = "oo.haru02w.eu.org";
    };

    nginx.virtualHosts = {
      "${config.services.nextcloud.hostName}" = {
        enableACME = true;
        forceSSL = true;
      };
      "${config.services.onlyoffice.hostname}" = {
        enableACME = true;
        forceSSL = true;
      };
    };

    cloudflared = {
      enable = true;
      tunnels = {
        "caf094a2-8ea9-4a78-a97d-041d3bbc1357" = {
          originRequest.noTLSVerify = true;
          credentialsFile = "${config.sops.secrets."cloudflared/nas-tunnel".path}";
          default = "http_status:404";
          ingress."*.haru02w.eu.org" = "https://localhost";
        };
      };
    };

    tailscale = {
      enable = true;
      useRoutingFeatures = "server";
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "haru02w@protonmail.com";
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
}
