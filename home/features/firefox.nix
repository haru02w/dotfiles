{inputs, pkgs, config, ...}:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
    profiles.${config.home.username} = {
      settings = {
        # Performance settings
        "gfx.webrender.all" = true; # Force enable GPU acceleration
        "media.ffmpeg.vaapi.enabled" = true;
        "widget.dmabuf.force-enabled" = true; # Required in recent Firefoxes

        # Keep the reader button enabled at all times; really don't
        # care if it doesn't work 20% of the time, most websites are
        # crap and unreadable without this
        "reader.parse-on-load.force-enabled" = true;

        # Hide the "sharing indicator", it's especially annoying
        # with tiling WMs on wayland
        "privacy.webrtc.legacyGlobalIndicator" = false;

        "app.update.auto" = false;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.discovery.enabled" = false;
        "browser.laterrun.enabled" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        "browser.download.panel.shown" = true;
        "general.autoScroll" = true;
      };
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        tokyo-night-v2 # theme
        simple-tab-groups
        ublock-origin
        sponsorblock
        enhancer-for-youtube
        df-youtube
        translate-web-pages
        darkreader
      ];
    };
  };
}
