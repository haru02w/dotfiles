{ config, pkgs, ... }:
let
  keys = ["/etc/ssh/ssh_host_ed25519_key"];
in {
  home.packages = with pkgs; [ sops ];

  sops = {
    defaultSopsFile = ../../secrets/accounts.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = keys;

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
