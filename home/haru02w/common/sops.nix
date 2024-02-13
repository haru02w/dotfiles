{ config, ... }:
let
  isEd25519 = k: k.type == "ed25519";
  getKeyPath = k: k.path;
  keys = builtins.filter isEd25519 config.services.openssh.hostKeys;
in {
  home.packages = with pkgs; [ sops ];

  sops = {
    defaultSopsFile = ../../secrets/accounts.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = map getKeyPath keys;

    secrets.rsa_id = {
      sopsFile = ../../secrets/ssh-keys.yaml;
      path = "${config.home.homeDirectory}/.ssh/id_rsa";
    };

    secrets.rsa_id_pub = {
      sopsFile = ../../secrets/ssh-keys.yaml;
      path = "${config.home.homeDirectory}/.ssh/id_rsa.pub";
    };
  };
}
