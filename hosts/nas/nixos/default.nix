{
  config,
  pkgs,
  ...
}: let
  ifGroupsExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  imports = [./setup];

  modules.settings = {
    enable = true;
    hostname = "nas";
    keymap = {
      layout = "us";
      options = "compose:ralt";
    };
    locale = "en_US.UTF-8";
    timezone = "America/Sao_Paulo";
  };

  modules.programs.ssh = {
    enable = true;
    enablePassword = true;
    enableRootLogin = false;
  };

  modules.presets.nas-v1 = {
    enable = true;
    adminpassFile = "${config.sops.secrets.nextcloud.path}";
    cloudflaredCredentialsFile = "${config.sops.secrets."cloudflared/nas-tunnel".path}";
  };
  services.nextcloud.poolSettings = {
    pm = "dynamic";
    "pm.max_children" = "105";
    "pm.max_requests" = "500";
    "pm.max_spare_servers" = "78";
    "pm.min_spare_servers" = "26";
    "pm.start_servers" = "26";
  };

  ### --- HARU02W --- ###
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/haru02w/.config/sops/age/keys.txt";
    secrets = {
      haru02w = {
        sopsFile = ../../../secrets/secrets.yaml;
        neededForUsers = true;
      };
      nextcloud = {
        owner = "nextcloud";
        group = "nextcloud";
        sopsFile = ../../../secrets/secrets.yaml;
      };

      "cloudflared/nas-tunnel" = {
        owner = "cloudflared";
        sopsFile = ../../../secrets/secrets.yaml;
      };
    };
  };
  # create required folder
  # systemd.tmpfiles.rules = [
  #   "d ${config.users.users.haru02w.home}/.cloudflared 700 haru02w users"
  # ];

  users.mutableUsers = false; # disable imperative passwords
  users.users = {
    root.hashedPasswordFile = "!"; # disable root login
    haru02w = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.haru02w.path;
      extraGroups =
        [
          "wheel"
          "input"
          "video"
          "audio"
        ]
        ++ ifGroupsExist [
          "lp"
          "networkmanager"
          "docker"
          "libvirtd"
          "git"
          "kvm"
        ];
    };
  };
  ### ---         --- ###
}
