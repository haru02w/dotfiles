{ inputs, ... }:
{
  flake-file = {
    # Do NOT set inputs.nixpkgs.follows here: following our nixpkgs rebuilds
    # noctalia + its quickshell fork from source. Leaving it pinned lets the
    # noctalia.cachix.org binary cache hit.
    inputs.noctalia-shell.url = "github:noctalia-dev/noctalia-shell";
    nixConfig = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };
  };

  den.aspects.noctalia.homeManager =
    { pkgs, ... }:
    {
      imports = [ inputs.noctalia-shell.homeModules.default ];

      programs.noctalia-shell = {
        enable = true;
        settings.idle.enabled = true;
        settings.idle.suspendTimeout = 0; # 0 = never auto-suspend on idle
        settings.general.lockOnSuspend = true;
        settings.dock.enabled = false;
        settings.bar = {
          position = "right";
          widgets = {
            left = [
              { id = "ControlCenter"; }
              { id = "Launcher"; }
              { id = "SystemMonitor"; }
              { id = "ActiveWindow"; }
              { id = "MediaMini"; }
            ];
            center = [
              { id = "Workspace"; }
            ];
            right = [
              { id = "Tray"; }
              { id = "NotificationHistory"; }
              { id = "Battery"; }
              { id = "Volume"; }
              { id = "Brightness"; }
              {
                id = "Clock";
                formatVertical = "HH mm - dd MMM";
              }
            ];
          };
        };
      };

      home.packages = with pkgs; [
        brightnessctl
        imagemagick
        python3
        cliphist
        wl-clipboard
        wlsunset
        grim
        slurp
      ];
    };
}
