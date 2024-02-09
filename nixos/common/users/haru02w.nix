# Main user for non-headless machines

{ pkgs, config, lib, ... }:
let
  user = "haru02w";
  sopsEnabled = (config ? sops);
  ifGroupsExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = lib.mkIf sopsEnabled false;
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPasswordFile = lib.mkIf sopsEnabled config.sops.secrets.${user}.path;
    #openssh.authorizedKeys.keys = [ (builtins.readfile ./././.) ];
    extraGroups = [ "wheel" "video" "audio" ]
      ++ ifGroupsExist [ "network" "docker" "podman" "libvirtd" "git" ];
    packages = [ pkgs.home-manager ];
  };

} // lib.mkIf sopsEnabled {
  sops.secrets.${user} = {
    sopsFile = ../../../secrets/accounts.yaml;
    neededForUsers = true;
  };
}
