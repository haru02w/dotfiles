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
    hostname = "zephyrus";
    keymap = {
      layout = "us";
      options = "compose:ralt";
    };
    locale = "en_US.UTF-8";
    timezone = "America/Sao_Paulo";
  };

  virtualisation.docker = {
    enable = true;
    extraPackages = [pkgs.docker-compose];
  };

  services.asusd = {
    enable = true;
    enableUserService = true;
  };
  modules.programs.plymouth.enable = true;

  modules.programs.ssh = {
    enable = true;
    enablePassword = false;
    enableRootLogin = false;
  };

  # services.ollama = {
  #   enable = true;
  #   package = pkgs.ollama-cuda;
  #   acceleration = "cuda";
  # };

  modules.presets.desktop-v2.enable = true;

  ### --- HARU02W --- ###
  modules.programs.home-manager.enable = true;
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/haru02w/.config/sops/age/keys.txt";
    secrets.haru02w = {
      sopsFile = ../../../secrets/secrets.yaml;
      neededForUsers = true;
    };
  };
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
