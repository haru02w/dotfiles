{ den, ... }:
{
  den.aspects.desktop = {
    includes = [
      den.aspects.headless
      den.aspects.pipewire
      den.aspects.playerctld
      den.aspects.plymouth
      den.aspects.ly
      den.aspects.udiskie
      den.aspects.virt-manager
      den.aspects.kdeconnect
      den.aspects.niri
      den.aspects.ghostty
      den.aspects.noctalia
      den.aspects.firefox
      den.aspects.vieb
      den.aspects.voxtype
    ];

    nixos =
      { pkgs, ... }:
      {
        hardware.graphics.enable = true;
        hardware.bluetooth.enable = true;
        services.power-profiles-daemon.enable = true;
        services.upower.enable = true;

        # extract this later
        services.tailscale.enable = true;

        i18n.inputMethod = {
          enable = true;
          type = "ibus";
        };
      };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          vesktop
          discord
        ];
      };
  };
}
