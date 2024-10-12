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
    adminpassFile = "${config.sops.secrets.haru02w.path}";
    hostName = "nc.haru02w.eu.org";
    cloudflaredCredentialsFile = "${config.sops.secrets."cloudflared/nas-tunnel".path}";
  };

  services.cloudflared = {
    user = "haru02w";
    group = "users";
  };

  ### --- HARU02W --- ###
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/haru02w/.config/sops/age/keys.txt";
    secrets.haru02w = {
      sopsFile = ../../../secrets/secrets.yaml;
      neededForUsers = true;
    };

    secrets."cloudflared/cert-pem" = {
      sopsFile = ../../../secrets/secrets.yaml;
      path = "${config.users.users.haru02w.homeDirectory}/.cloudflared/cert.pem";
    };
  };
  # create required folder
  # systemd.tmpfiles.rules = [
  #   "d ${config.users.users.haru02w.homeDirectory}/.cloudflared 700 haru02w users"
  # ];

  users.mutableUsers = false; # disable imperative passwords
  users.users = {
    root.hashedPasswordFile = "!"; # disable root login
    haru02w = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.haru02w.path;
      shell = pkgs.zsh;
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
