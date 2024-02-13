{ config, ... }: {
  programs.waybar = with config.colorScheme.palette; {
    enable = true;
    systemd.enable = true;
  };
}
