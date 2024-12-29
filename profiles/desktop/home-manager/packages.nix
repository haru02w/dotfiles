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

    # CLI
    nixvim
    lazygit
    progress
    libqalculate
    ncdu
    pulsemixer
    btop
    neofetch
    tldr
    zip
    unzip

    # Window Manager
    wl-clipboard # clipboard on wayland
    libnotify # notifications
    brightnessctl # change brightness
    grimblast # screenshots
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

  # NixVim (Neovim) Set default editor
  home.sessionVariables.EDITOR = "nvim";

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
    ignoreTimeout = true;
    defaultTimeout = 5000;
  };
  # Rofi
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
  # Tmux
  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-Space";
    keyMode = "vi";
    clock24 = true;
    terminal = "screen-256color";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = true;
    sensibleOnTop = true;
    customPaneNavigationAndResize = true;
    plugins = with pkgs; [
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim "session"
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore "on"
          set -g @continuum-save-interval "15" # minutes
        '';
      }
    ];
    extraConfig = ''
      is_vim="${pkgs.procps}/bin/ps -o state= -o comm= -t '#{pane_tty}' \
        | ${pkgs.gnugrep}/bin/grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      tmux="${pkgs.tmux}/bin/tmux"

      # OPTIONS

      # keep server running after first run
      set-option -s exit-empty off

      # Automatically set window title
      set-window-option -g automatic-rename on
      set-option -g set-titles on

      # Highlight active window
      setw -g monitor-activity on

      set -g focus-events on

      set-option -g automatic-rename on
      set-option -g automatic-rename-format "#{b:pane_current_path}"

      # KEYBINDS

      # Close session
      bind q kill-session

      # Maximize pane size
      bind m resize-pane -Z

      # Delete pane
      bind c kill-pane

      # Split panes
      bind \\ split-window -v
      bind | split-window -h

      # Start selection
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      # copy content
      bind-key -T copy-mode-vi y send-keys -X copy-selection

      # Enter copy-mode
      unbind [
      unbind ]
      bind-key v copy-mode
      bind-key p paste-buffer

      # select panes on copy mode
      bind-key -T copy-mode-vi "M-h" select-pane -L
      bind-key -T copy-mode-vi "M-j" select-pane -D
      bind-key -T copy-mode-vi "M-k" select-pane -U
      bind-key -T copy-mode-vi "M-l" select-pane -R
      bind-key -T copy-mode-vi "M-\\" select-pane -l

      # selecting panes
      bind-key -n M-h if-shell "$is_vim" "send-keys M-h"  "select-pane -L"
      bind-key -n M-j if-shell "$is_vim" "send-keys M-j"  "select-pane -D"
      bind-key -n M-k if-shell "$is_vim" "send-keys M-k"  "select-pane -U"
      bind-key -n M-l if-shell "$is_vim" "send-keys M-l"  "select-pane -R"

      # resizing panes
      bind-key -n C-M-h if-shell "$is_vim" "send-keys C-M-h" "resize-pane -L 3"
      bind-key -n C-M-j if-shell "$is_vim" "send-keys C-M-j" "resize-pane -D 3"
      bind-key -n C-M-k if-shell "$is_vim" "send-keys C-M-k" "resize-pane -U 3"
      bind-key -n C-M-l if-shell "$is_vim" "send-keys C-M-l" "resize-pane -R 3"

      # swaping panes
      bind-key -n M-H if-shell "$is_vim" "send-keys M-H" "swap-pane -D"
      bind-key -n M-J if-shell "$is_vim" "send-keys M-J" "swap-pane -D"
      bind-key -n M-K if-shell "$is_vim" "send-keys M-K" "swap-pane -U"
      bind-key -n M-L if-shell "$is_vim" "send-keys M-L" "swap-pane -U"

      #Auto windowing
      bind-key 1 if-shell "$tmux select-window -t :1" "" "new-window -t :1"
      bind-key 2 if-shell "$tmux select-window -t :2" "" "new-window -t :2"
      bind-key 3 if-shell "$tmux select-window -t :3" "" "new-window -t :3"
      bind-key 4 if-shell "$tmux select-window -t :4" "" "new-window -t :4"
      bind-key 5 if-shell "$tmux select-window -t :5" "" "new-window -t :5"
      bind-key 6 if-shell "$tmux select-window -t :6" "" "new-window -t :6"
      bind-key 7 if-shell "$tmux select-window -t :7" "" "new-window -t :7"
      bind-key 8 if-shell "$tmux select-window -t :8" "" "new-window -t :8"
      bind-key 9 if-shell "$tmux select-window -t :9" "" "new-window -t :9"
      bind-key 0 if-shell "$tmux select-window -t :10" "" "new-window -t :10"

      # THEME
      set -g status-style bg=default
      set -g status-left-length 90
      set -g status-right-length 90
      set -g status-justify absolute-centre
      set -g status-left "#[fg=green] ❐ #S #[default]"
      set -g status-right "#[fg=colour172,bright,bg=default] 󰅐 %H:%M #[default]"
      set -ag status-right "#[fg=white,bg=default]  %a %d #[default]"
    '';
  };
  # Firefox
  programs.firefox = {
    enable = true;
    profiles.${config.home.username} = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
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

  # ZSH
  programs.zsh = {
    enable = true;
    autocd = true;
    defaultKeymap = "emacs";
    #plugins
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = ["^[[A"];
      searchDownKey = ["^[[B"];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./non-nix;
        file = "p10k.zsh";
      }
    ];

    initExtraBeforeCompInit = ''
      # p10k instant prompt
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';

    /*
    envExtra =''
      setopt no_global_rcs
    '';
    */

    history = {
      expireDuplicatesFirst = true;
      ignoreSpace = false;
      share = true;
      save = 15000;
    };

    shellAliases = {
      nixos-switch = "sudo nixos-rebuild switch --flake ~/.dotfiles";
      nixos-boot = "sudo nixos-rebuild boot --flake ~/.dotfiles";
      # `tmux` stuff
      tm = "tmux new -c $(find * -type d | fzf)";
      cdf = "cd $(find * -type d | fzf)";
      # `bat` stuff
      cat = "bat";
      man = "batman";
      rg = "batgrep";
      watch = "batwatch";
      # git stuff
      gs = "git status";
      ga = "git add -A";
      gc = "git commit";
      gp = "git push";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batwatch];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    # config.global.strict_env = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  home.sessionVariables.DIRENV_LOG_FORMAT = "";
}
