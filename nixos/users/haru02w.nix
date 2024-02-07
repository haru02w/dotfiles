# Main user for non-headless machines

{ pkgs, config, ... }:
let
  user = "haru02w";
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  imports = [ ../common/optional/home-manager.nix ];

  users.mutableUsers = false;
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets.${user}.path;
    #openssh.authorizedKeys.keys = [ (builtins.readfile ./././.) ];
    extraGroups = [ "wheel" "video" "audio" ]
      ++ ifTheyExist [ "network" "docker" "podman" "libvirtd" "git" ];
    packages = [ pkgs.home-manager ];
  };

  sops = {
    sops.secrets.${user} = {
      sopsFile = ../../secrets/accounts.yaml;
      neededForUsers = true;
    };
  };
}
