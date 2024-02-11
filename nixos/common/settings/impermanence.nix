{ config, ... }: { # bind folders from persist to everywhere else
  environment.persistence = {
    "/persist" = {
      directories = [
        "/etc/NetworkManager/system-connections" # wifi passwords
        "/var/lib/bluetooth" # bluetooth connections
        "/var/lib/systemd"
        "/var/lib/nixos"
        "/var/log" # logs
        "/var/lib/tailscale" # tailscale login
        "/etc/asusd" # asusctl state
      ];
      files = [
        "/root/.local/share/nix/trusted-settings.json"
        config.sops.age.keyFile
      ];
    };
  };
  programs.fuse.userAllowOther = true;
}
