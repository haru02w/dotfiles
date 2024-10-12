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
    inherit (options.services.nextcloud.config) adminpassFile;
    inherit (options.services.nextcloud) hostName;
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
        maxUploadSize = "1G";
        inherit (cfg) hostName;
        config.adminpassFile = cfg.adminpassFile;
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
            notify_push
            previewgenerator
            ;
        };
        extraAppsEnable = true;
      };
      nginx.virtualHosts.${config.services.nextcloud.hostName} = {
        forceSSL = true;
        enableACME = true;
      };

      cloudflared = {
        enable = true;
        tunnels = {
          "caf094a2-8ea9-4a78-a97d-041d3bbc1357" = {
            credentialsFile = cfg.cloudflaredCredentialsFile;
            default = "http_status:404";
            ingress."${config.services.nextcloud.hostName}" = "https://localhost:443";
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
      certs = {
        ${config.services.nextcloud.hostName}.email = "haru02w@protonmail.com";
      };
    };

    environment.systemPackages = with pkgs; [
      neovim # text editor
      git # version control system
      wget # downloader
    ];
  };
}
