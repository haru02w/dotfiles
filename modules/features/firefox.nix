{ inputs, ... }:
{
  flake-file.inputs.nur.url = "github:nix-community/NUR";

  den.aspects.firefox.homeManager =
    {
      pkgs,
      config,
      ...
    }:
    {
      nixpkgs.overlays = [ inputs.nur.overlays.default ];

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/about" = "firefox.desktop";
          "x-scheme-handler/unknown" = "firefox.desktop";
          # preserve previously-set imperative handlers
          "x-scheme-handler/discord" = "vesktop.desktop";
          "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
        };
      };

      stylix.targets.firefox.profileNames = [ "${config.home.username}" ];
      programs.firefox = {
        enable = true;
        profiles.${config.home.username} = {
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            darkreader
            bitwarden
            translate-web-pages
            enhancer-for-youtube
            sponsorblock
            df-youtube
            vimium
          ];

          settings = {
            "svg.context-properties.content.enabled" = true;
            "media.ffmpeg.vaapi.enabled" = true;
            "layout.css.prefers-color-scheme.content-override" = 0;
            "browser.uiCustomization.state" = ''
              {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["_3c078156-979c-498b-8990-85f7987dd929_-browser-action","sponsorblocker_ajay_app-browser-action","addon_darkreader_org-browser-action","dfyoutube_example_com-browser-action","enhancerforyoutube_maximerf_addons_mozilla_org-browser-action","_036a55b4-5e72-4d05-a06c-cba2dfcc134a_-browser-action","copyfish_a9t9_com-browser-action","firefox-translations-addon_mozilla_org-browser-action"],"nav-bar":["back-button","stop-reload-button","forward-button","simple-tab-groups_drive4ik-browser-action","vertical-spacer","urlbar-container","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","ublock0_raymondhill_net-browser-action","unified-extensions-button","reset-pbm-toolbar-button","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","downloads-button","alltabs-button","sidebar-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","addon_darkreader_org-browser-action","dfyoutube_example_com-browser-action","enhancerforyoutube_maximerf_addons_mozilla_org-browser-action","simple-tab-groups_drive4ik-browser-action","sponsorblocker_ajay_app-browser-action","_036a55b4-5e72-4d05-a06c-cba2dfcc134a_-browser-action","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","_3c078156-979c-498b-8990-85f7987dd929_-browser-action","copyfish_a9t9_com-browser-action","reset-pbm-toolbar-button","screenshot-button","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","firefox-translations-addon_mozilla_org-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","unified-extensions-area","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list","vertical-tabs"],"currentVersion":24,"newElementCount":12}
            '';
            "signon.rememberSignons" = false;
            "general.autoScroll" = true;
            "toolkit.winRegisterApplicationRestart" = true;
            "browser.tabs.firefox-view" = false;
            "browser.tabs.firefox-view-next" = false;
            "browser.tabs.groups.enabled" = true;
            "browser.tabs.insertAfterCurrent" = true;
            "browser.tabs.insertRelatedAfterCurrent" = true;
            "browser.shell.checkDefaultBrowser" = false;
            "browser.aboutConfig.showWarning" = false;
            "browser.startup.page" = 3;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.default.sites" = "";
            "geo.provider.network.url" =
              "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
            "geo.provider.ms-windows-location" = false;
            "geo.provider.use_corelocation" = false;
            "geo.provider.use_gpsd" = false;
            "geo.provider.use_geoclue" = false;
            "extensions.getAddons.showPane" = false;
            "extensions.htmlaboutaddons.recommendations.enabled" = false;
            "browser.discovery.enabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.server" = "data:,";
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.updatePing.enabled" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.coverage.opt-out" = true;
            "toolkit.coverage.opt-out" = true;
            "toolkit.coverage.endpoint.base" = "";
            "browser.ping-centre.telemetry" = false;
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "app.shield.optoutstudies.enabled" = false;
            "app.normandy.enabled" = false;
            "app.normandy.api_url" = "";
            "breakpad.reportURL" = "";
            "browser.tabs.crashReporting.sendReport" = false;
            "captivedetect.canonicalURL" = "";
            "network.captive-portal-service.enabled" = false;
            "network.connectivity-service.enabled" = false;
            "browser.safebrowsing.downloads.remote.enabled" = false;
            "browser.urlbar.suggest.quicksuggest.sponsored" = false;
            "browser.urlbar.trending.featureGate" = false;
            "browser.urlbar.addons.featureGate" = false;
            "browser.urlbar.mdn.featureGate" = false;
            "browser.formfill.enable" = false;
            "signon.autofillForms" = false;
            "signon.formlessCapture.enabled" = false;
            "browser.privatebrowsing.forceMediaMemoryCache" = true;
            "browser.contentblocking.category" = "strict";
            "browser.download.useDownloadDir" = false;
            "browser.download.alwaysOpenPanel" = true;
            "browser.download.manager.addToRecentDocs" = false;
            "browser.download.always_ask_before_handling_new_types" = true;
            "extensions.webextensions.restrictedDomains" = "";
            "privacy.resistFingerprinting.block_mozAddonManager" = true;
            "browser.startup.homepage_override.mstone" = "ignore";
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
            "browser.messaging-system.whatsNewPanel.enabled" = false;
            "sidebar.verticalTabs" = true;
            "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
            "sidebar.visibility" = "expand-on-hover";
            "sidebar.position_start" = false;
          };
        };
      };
    };
}
