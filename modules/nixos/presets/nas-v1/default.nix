{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.presets.nas-v1;
in {
  options.modules.presets.nas-v1 = {
    enable = mkEnableOption "nas-v1 preset";
    adminpassFile = mkOption {
      type = types.str;
    };
    cloudflaredCredentialsFile = mkOption {
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
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
        #autoUpdateApps.enable = true;
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
          overwriteprotocol = "https";
          default_phone_region = "BR";
        };
        config = {
          dbtype = "pgsql";
          adminuser = "haru02w";
          inherit (cfg) adminpassFile;
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
            credentialsFile = cfg.cloudflaredCredentialsFile;
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

    environment.systemPackages = with pkgs; [
      neovim # text editor
      git # version control system
      wget # downloader
    ];
  };
}
