{ # bind folders from persist to everywhere else
  environment.persistence = {
    "/persist" = {
      directories = [
        # TODO: setup impermanence in home-manager and remove home
        "/home" # whole home folder
        "/etc/NetworkManager/system-connections" # wifi passwords
        "/var/lib/bluetooth" # bluetooth connections
        "/var/lib/systemd"
        "/var/lib/nixos"
        "/var/log" # logs
        "/var/lib/tailscale" # tailscale login
        "/etc/asusd" # asusctl state
      ];
      files = [ "/root/.local/share/nix/trusted-settings.json" ];
    };
  };
  programs.fuse.userAllowOther = true;
}
