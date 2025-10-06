{
  config,
  inputs,
  lib,
  ...
}: {
  imports = builtins.attrValues inputs.self.outputs.homeModules;
  # Settings
  home = {
    username = baseNameOf ./..;
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "24.05";
  };

  # Git config
  programs.git = {
    enable = true;
    userName = config.home.username;
    userEmail = "joaovictormillane@gmail.com";
  };

  # Password manager
  sops = {
    defaultSopsFile = lib.flakeRoot + "/secrets/secrets.yaml";
    defaultSopsFormat = "yaml";
    age.keyFile = lib.mkDefault "/${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets."ssh/key" = {
      sopsFile = lib.flakeRoot + "/secrets/secrets.yaml";
      path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    };

    secrets."ssh/pub" = {
      sopsFile = lib.flakeRoot + "/secrets/secrets.yaml";
      path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
    };
  };
}
