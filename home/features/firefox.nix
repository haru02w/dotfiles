{ pkgs, config, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    # package = pkgs.firefox-devedition-bin;
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
        # https://support.mozilla.org/bm/questions/1358615

        ##UI
        # Set dark mode
        "layout.css.prefers-color-scheme.content-override" = 0;
        "browser.uiCustomization.state" = ''
          {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["sponsorblocker_ajay_app-browser-action","addon_darkreader_org-browser-action","dfyoutube_example_com-browser-action","enhancerforyoutube_maximerf_addons_mozilla_org-browser-action","_036a55b4-5e72-4d05-a06c-cba2dfcc134a_-browser-action"],"nav-bar":["back-button","stop-reload-button","forward-button","customizableui-special-spring1","simple-tab-groups_drive4ik-browser-action","urlbar-container","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","downloads-button","unified-extensions-button","ublock0_raymondhill_net-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","addon_darkreader_org-browser-action","dfyoutube_example_com-browser-action","enhancerforyoutube_maximerf_addons_mozilla_org-browser-action","simple-tab-groups_drive4ik-browser-action","sponsorblocker_ajay_app-browser-action","_036a55b4-5e72-4d05-a06c-cba2dfcc134a_-browser-action","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","unified-extensions-area","toolbar-menubar","TabsToolbar"],"currentVersion":20,"newElementCount":6}
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
        # set startup page
        # 0=blank, 1=home, 2=last visited page, 3=resume previous session
        "browser.startup.page" = 3;
        # set homepage
        #about:home=Firefox Home (default), custom URL, about:blank
        "browser.startup.homepage" = "about:blank";
        # set NEWTAB page
        # true=Firefox Home (default), false=blank page
        "browser.newtabpage.enabled" = false;
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
/* user_pref("app.normandy.api_url", "");
   user_pref("app.normandy.enabled", false);
   user_pref("app.shield.optoutstudies.enabled", false);
   user_pref("app.update.auto", false);
   user_pref("beacon.enabled", false);
   user_pref("breakpad.reportURL", "");
   user_pref("browser.aboutConfig.showWarning", false);
   user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false);
   user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
   user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
   user_pref("browser.disableResetPrompt", true);
   user_pref("browser.newtab.preload", false);
   user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
   user_pref("browser.newtabpage.enhanced", false);
   user_pref("browser.newtabpage.introShown", true);
   user_pref("browser.safebrowsing.appRepURL", "");
   user_pref("browser.safebrowsing.blockedURIs.enabled", false);
   user_pref("browser.safebrowsing.downloads.enabled", false);
   user_pref("browser.safebrowsing.downloads.remote.enabled", false);
   user_pref("browser.safebrowsing.downloads.remote.url", "");
   user_pref("browser.safebrowsing.enabled", false);
   user_pref("browser.safebrowsing.malware.enabled", false);
   user_pref("browser.safebrowsing.phishing.enabled", false);
   user_pref("browser.selfsupport.url", "");
   user_pref("browser.send_pings", false);
   user_pref("browser.sessionstore.privacy_level", 0);
   user_pref("browser.shell.checkDefaultBrowser", false);
   user_pref("browser.startup.homepage_override.mstone", "ignore");
   user_pref("browser.tabs.crashReporting.sendReport", false);
   user_pref("browser.urlbar.groupLabels.enabled", false);
   user_pref("browser.urlbar.quicksuggest.enabled", false);
   user_pref("browser.urlbar.trimURLs", false);
   user_pref("datareporting.healthreport.service.enabled", false);
   user_pref("datareporting.healthreport.uploadEnabled", false);
   user_pref("datareporting.policy.dataSubmissionEnabled", false);
   user_pref("device.sensors.ambientLight.enabled", false);
   user_pref("device.sensors.enabled", false);
   user_pref("device.sensors.motion.enabled", false);
   user_pref("device.sensors.orientation.enabled", false);
   user_pref("device.sensors.proximity.enabled", false);
   user_pref("dom.battery.enabled", false);
   user_pref("dom.event.clipboardevents.enabled", false);
   user_pref("dom.webaudio.enabled", false);
   user_pref("experiments.activeExperiment", false);
   user_pref("experiments.enabled", false);
   user_pref("experiments.manifest.uri", "");
   user_pref("experiments.supported", false);
   user_pref("extensions.getAddons.cache.enabled", false);
   user_pref("extensions.getAddons.showPane", false);
   user_pref("extensions.greasemonkey.stats.optedin", false);
   user_pref("extensions.greasemonkey.stats.url", "");
   user_pref("extensions.pocket.enabled", false);
   user_pref("extensions.shield-recipe-client.api_url", "");
   user_pref("extensions.shield-recipe-client.enabled", false);
   user_pref("extensions.webservice.discoverURL", "");
   user_pref("media.autoplay.default", 0);
   user_pref("media.autoplay.enabled", true);
   user_pref("media.eme.enabled", false);
   user_pref("media.gmp-widevinecdm.enabled", false);
   user_pref("media.navigator.enabled", false);
   user_pref("media.video_stats.enabled", false);
   user_pref("network.allow-experiments", false);
   user_pref("network.captive-portal-service.enabled", false);
   user_pref("network.cookie.cookieBehavior", 1);
   user_pref("network.http.referer.spoofSource", true);
   user_pref("network.trr.mode", 5);
   user_pref("privacy.donottrackheader.enabled", true);
   user_pref("privacy.donottrackheader.value", 1);
   user_pref("privacy.query_stripping", true);
   user_pref("privacy.trackingprotection.cryptomining.enabled", true);
   user_pref("privacy.trackingprotection.enabled", true);
   user_pref("privacy.trackingprotection.fingerprinting.enabled", true);
   user_pref("privacy.trackingprotection.pbmode.enabled", true);
   user_pref("privacy.usercontext.about_newtab_segregation.enabled", true);
   user_pref("security.ssl.disable_session_identifiers", true);
   user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite", false);
   user_pref("signon.autofillForms", false);
   user_pref("toolkit.telemetry.archive.enabled", false);
   user_pref("toolkit.telemetry.bhrPing.enabled", false);
   user_pref("toolkit.telemetry.cachedClientID", "");
   user_pref("toolkit.telemetry.enabled", false);
   user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
   user_pref("toolkit.telemetry.hybridContent.enabled", false);
   user_pref("toolkit.telemetry.newProfilePing.enabled", false);
   user_pref("toolkit.telemetry.prompted", 2);
   user_pref("toolkit.telemetry.rejected", true);
   user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
   user_pref("toolkit.telemetry.server", "");
   user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
   user_pref("toolkit.telemetry.unified", false);
   user_pref("toolkit.telemetry.unifiedIsOptIn", false);
   user_pref("toolkit.telemetry.updatePing.enabled", false);
   user_pref("webgl.renderer-string-override", " ");
   user_pref("webgl.vendor-string-override", " ");
*/
