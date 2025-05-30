{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # GUI
    discord
    vesktop

    # Window Manager
    wl-clipboard # clipboard on wayland
    libnotify # notifications
    brightnessctl # change brightness
    sway-contrib.grimshot
    pulsemixer
    seafile-client
  ];

  # MIME
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "default-web-browser" = ["firefox.desktop"];
      "text/html" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "x-scheme-handler/about" = ["firefox.desktop"];
      "x-scheme-handler/unknown" = ["firefox.desktop"];
    };
  };

  # Foot
  programs.foot = {
    enable = true;
    server.enable = true;
    settings.main.dpi-aware = lib.mkForce "no";
  };

  # Waybar
  programs.waybar = with config.lib.stylix.colors; {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";
    settings.mainBar = {
      layer = "top";
      position = "right";
      modules-left = [
        # "custom/fanprofiles"
        "cpu"
        "memory"
        "battery"
        "custom/separator"
        "tray"
      ];
      modules-center = ["sway/workspaces"];
      modules-right = [
        "network"
        "bluetooth"
        "backlight"
        "pulseaudio"
        "custom/separator"
        "clock"
      ];
      "clock" = {
        format = ''
          {:%H
          %M}'';
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            months = "<span color='#ffead3'><b>{}</b></span>";
            days = "<span color='#ecc6d9'><b>{}</b></span>";
            weeks = "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-click-forward = "tz_up";
          on-click-backward = "tz_down";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };
      "custom/separator" = {format = "───";};
      "cpu" = {
        format = "󰍛 {icon}";
        format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
      };
      "memory" = {
        format = " {icon}";
        format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
        tooltip = true;
        tooltip-format = "{used}/{total}, {percentage}% used";
      };
      "backlight" = {
        format = "{icon}";
        format-icons = ["" "" "" "" "" "" "" "" ""];
        tooltip = true;
        tooltip-format = "{percent}%";
      };
      "pulseaudio" = {
        format = "󱄠 {icon}";
        format-muted = "󰸈";
        format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
        tooltip = true;
        tooltip-format = "{volume}%";
      };
      "battery" = {
        format = "{icon}";
        format-charging = "<span color='#${base0B}'>{icon}</span>";
        format-warning = "<span color='#${base0A}'>{capacity}%</span>";
        format-critical = "<span color='#${base08}'>{capacity}%</span>";
        tooltip = true;
        tooltip-format = "{capacity}%";
        states = {
          warning = 30;
          critical = 15;
        };
        format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󱟢"];
      };
      "network" = {
        format = "";
        format-ethernet = "󰈁";
        format-wifi = "{icon}";
        format-disconnected = "󰈂";
        format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        tooltip = true;
        tooltip-format = ''
          {essid}
          {signalStrength} UP:{bandwidthUpBytes} DOWN:{bandwidthDownBytes}'';
        on-click = "${pkgs.networkmanager_dmenu}/bin/networkmanager_dmenu";
      };
      "bluetooth" = {
        format = "";
        format-on = "󰂯";
        format-off = "󰂲";
        format-disabled = "󰂲";
        format-connected = "󰂱";
        on-click = "${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
      };
      #   "custom/fanprofiles" = {
      #     interval = "once";
      #     signal = 8;
      #     format = "{}";
      #     exec-on-event = false;
      #     on-click =
      #       "${pkgs.asusctl}/bin/asusctl profile -n; ${pkgs.procps}/bin/pkill -RTMIN+8 waybar";
      #     exec =
      #       let
      #         script = pkgs.writeShellScriptBin "fanprofiles.sh" ''
      #           RETURN=$(${pkgs.asusctl}/bin/asusctl profile -p)
      #
      #           if [[ $RETURN = *"Performance"* ]]
      #           then
      #               echo "󱑴"
      #           elif [[ $RETURN = *"Balanced"* ]]
      #           then
      #               echo "󱑳"
      #           elif [[ $RETURN = *"Quiet"* ]]
      #           then
      #               echo "󱑲"
      #           fi
      #         '';
      #       in
      #       "${script}/bin/fanprofiles.sh"; # WARN
      #     escape = true;
      #   };
    };

    style = ''
      * {
        padding: 0;
      	/* border-radius: .8rem; */
      	font-size: 1.2rem;
      }

      window#waybar {
        padding: 0;
        margin-left: .2rem;
      	background-color: transparent;
        color: #${base05};
      }

      tooltip {
      	background-color: #${base00};
      }

      tooltip label {
      	color: #${base05};
      }

      .modules-left {
      	background-color: #${base00};
      	border-radius: .8rem;
      	padding: .2rem 0;
      	margin-left: .2rem;
      }

      .modules-center {
      	background-color: #${base00};
      	border-radius: .8rem;
      	padding: .2rem 0;
      	margin-left: .2rem;
      }

      .modules-right {
      	background-color: #${base00};
      	border-radius: .8rem;
      	padding: .2rem 0;
      	margin-left: .2rem;
      }

      #workspaces button {
        color: #${base05};
      	border: .1rem solid transparent;
      	padding: 0;
      }

      #workspaces button.active {
      	color: #${base0D};
      }

      #workspaces button:hover {
      	background: transparent;
      	border: .1rem solid #${base0D};
      }

      #cpu,
      #memory,
      #battery,
      #tray,
      #network,
      #bluetooth,
      #backlight,
      #pulseaudio,
      #clock {
      	padding: .1rem;
      }
    '';
  };

  # Mako
  services.mako = {
    enable = true;
    settings = {
      ignore-timeout = true;
      default-timeout = 5000;
    };
  };

  # Rofi
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  # Firefox

  stylix.targets.firefox.profileNames = ["${config.home.username}"];
  programs.firefox = {
    enable = true;
    profiles.${config.home.username} = {
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
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
        # enable dark color on STG
        "svg.context-properties.content.enabled" = true;
        #enable hardware acceleration
        "media.ffmpeg.vaapi.enabled" = true;
        # dark mode
        "layout.css.prefers-color-scheme.content-override" = 0;
        # UI layout
        "browser.uiCustomization.state" = ''
          {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["_3c078156-979c-498b-8990-85f7987dd929_-browser-action","sponsorblocker_ajay_app-browser-action","addon_darkreader_org-browser-action","dfyoutube_example_com-browser-action","enhancerforyoutube_maximerf_addons_mozilla_org-browser-action","_036a55b4-5e72-4d05-a06c-cba2dfcc134a_-browser-action","copyfish_a9t9_com-browser-action"],"nav-bar":["back-button","stop-reload-button","forward-button","simple-tab-groups_drive4ik-browser-action","sidebar-button","urlbar-container","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","ublock0_raymondhill_net-browser-action","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","downloads-button","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","addon_darkreader_org-browser-action","dfyoutube_example_com-browser-action","enhancerforyoutube_maximerf_addons_mozilla_org-browser-action","simple-tab-groups_drive4ik-browser-action","sponsorblocker_ajay_app-browser-action","_036a55b4-5e72-4d05-a06c-cba2dfcc134a_-browser-action","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","_3c078156-979c-498b-8990-85f7987dd929_-browser-action","copyfish_a9t9_com-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","unified-extensions-area","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":20,"newElementCount":11}
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
        "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
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
