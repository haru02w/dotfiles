{ config, lib, ... }: {
  # bind folders from persist to everywhere else
  fileSystems."/persist".neededForBoot = true;
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
        "/var/lib/ollama"
        "/etc/ssh"
        "/root/.local/share/nix/"
      ];
    };
  };
  system.activationScripts.persistent-dirs.text =
    let
      mkHomePersist = user:
        lib.optionalString user.createHome ''
          mkdir -p /persist/${user.home}
          chown ${user.name}:${user.group} /persist/${user.home}
          chmod ${user.homeMode} /persist/${user.home}
        '';
      users = lib.attrValues config.users.users;
    in
    lib.concatLines (map mkHomePersist users);
  programs.fuse.userAllowOther = true;
}
