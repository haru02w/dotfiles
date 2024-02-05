# This file defines the "non-hardware dependent" part of opt-in persistence
# It imports impermanence, defines the basic persisted dirs, and ensures each
# users' home persist dir exists and has the right permissions
#
# It works even if / is tmpfs, btrfs snapshot, or even not ephemeral at all.
{ config, ... }: {

  environment.persistence = {
    "/persist" = {
      directories = [
        "/home/${config.users.main_user}" # whole home folder
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
