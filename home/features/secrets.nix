{ inputs, pkgs, config, ... }: {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];
  home.packages = with pkgs; [ sops ];

  sops = {
    defaultSopsFile = ../../secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/haru02w/.config/sops/age/keys.txt";

    secrets.ssh_id = {
      path = "${config.home.homeDirectory}/.ssh/id_rsa";
    };

    secrets.ssh_id_pub = {
      path = "${config.home.homeDirectory}/.ssh/id_rsa.pub";
    };
  };
}
