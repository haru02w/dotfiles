{ pkgs, config, ... }: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "default-web-browser" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox.desktop" ];
    };
  };
  programs.firefox = {
    enable = true;
    profiles.${config.home.username} = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        tokyo-night-v2
        simple-tab-groups
        ublock-origin
        sponsorblock
        enhancer-for-youtube
        df-youtube
        translate-web-pages
        darkreader
        bitwarden
      ];

      settings = {
        #enable hardware acceleration
        "media.ffmpeg.vaapi.enabled" = true;
        # dark mode
        "layout.css.prefers-color-scheme.content-override" = 0;
        # UI layout
        "browser.uiCustomization.state" = ''
          {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["sponsorblocker_ajay_app-browser-action","addon_darkreader_org-browser-action","dfyoutube_example_com-browser-action","enhancerforyoutube_maximerf_addons_mozilla_org-browser-action","_036a55b4-5e72-4d05-a06c-cba2dfcc134a_-browser-action"],"nav-bar":["back-button","stop-reload-button","forward-button","simple-tab-groups_drive4ik-browser-action","urlbar-container","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","downloads-button","unified-extensions-button","ublock0_raymondhill_net-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","addon_darkreader_org-browser-action","dfyoutube_example_com-browser-action","enhancerforyoutube_maximerf_addons_mozilla_org-browser-action","simple-tab-groups_drive4ik-browser-action","sponsorblocker_ajay_app-browser-action","_036a55b4-5e72-4d05-a06c-cba2dfcc134a_-browser-action","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","unified-extensions-area","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":20,"newElementCount":9}
        '';
        # Disable fireofx password manager
        "signon.rememberSignons" = false;
        # Enable auto scroll
        "general.autoScroll" = true;
        # restore session after reboot
        "toolkit.winRegisterApplicationRestart" = true;
        # disable Firefox View pinned at startup
        "browser.tabs.firefox-view" = false;
        "browser.tabs.firefox-view-next" = false;

        #disable default browser check
        "browser.shell.checkDefaultBrowser" = false;
        #disable about:config warning
        "browser.aboutConfig.showWarning" = false;
        # restore previous session
        "browser.startup.page" = 3;
        # disable sponsored content on Firefox Home
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        # clear default topsites
        "browser.newtabpage.activity-stream.default.sites" = "";
        # use Mozilla geolocation service instead of Google if permission is granted
        "geo.provider.network.url" =
          "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
        # disable using OS's geolocation
        "geo.provider.ms-windows-location" = false; # WINDOWS
        "geo.provider.use_corelocation" = false; # MAC
        "geo.provider.use_gpsd" = false; # LINUX
        "geo.provider.use_geoclue" = false; # LINUX
        # disable addons recomendations (google analytics)
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        # disable new data submission
        "datareporting.policy.dataSubmissionEnabled" = false;
        # disable healt report
        "datareporting.healthreport.uploadEnabled" = false;
        # disable telemetry
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        # disable Telemetry Coverage
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        # disable PingCentre telemetry
        "browser.ping-centre.telemetry" = false;
        # disable Firefox Home telemetry
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        # disable studies
        "app.shield.optoutstudies.enabled" = false;
        # disable Normandy/Shield
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        # disable crash reports
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        # disable login pages in public wifis
        "captivedetect.canonicalURL" = "";
        "network.captive-portal-service.enabled" = false;
        # disable connectivity checks
        "network.connectivity-service.enabled" = false;
        # disable check downloads
        "browser.safebrowsing.downloads.remote.enabled" = false;
        # disable sponsored suggestions
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        # disable unwanted suggestions
        "browser.urlbar.trending.featureGate" = false;
        "browser.urlbar.addons.featureGate" = false;
        "browser.urlbar.mdn.featureGate" = false;
        # disable search and form history
        "browser.formfill.enable" = false;
        # disable auto-filling username & password form fields
        "signon.autofillForms" = false;
        # disable formless login capture for Password Manager
        "signon.formlessCapture.enabled" = false;
        # disable media cache from writing to disk in Private Browsing
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "browser.contentblocking.category" = "strict";
        # ask what folder to download
        "browser.download.useDownloadDir" = false;
        "browser.download.alwaysOpenPanel" = true;
        "browser.download.manager.addToRecentDocs" = false;
        # ask how to handle new types
        "browser.download.always_ask_before_handling_new_types" = true;
        # enable extensions on mozilla restricted domains
        "extensions.webextensions.restrictedDomains" = "";
        "privacy.resistFingerprinting.block_mozAddonManager" = true;
        # disable welcome page
        "browser.startup.homepage_override.mstone" = "ignore";
        # disable recommend extensions/features as you browse
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" =
          false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" =
          false;
        # disable What's new page
        "browser.messaging-system.whatsNewPanel.enabled" = false;
      };
    };
  };
}
