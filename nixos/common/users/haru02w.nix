# Main user for non-headless machines
{ pkgs, config, ... }:
let
  user = "haru02w";
  ifGroupsExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;

  users.users = {
    root.hashedPasswordFile = "!"; # disable root login
    ${user} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      hashedPasswordFile = config.sops.secrets.${user}.path;
      #openssh.authorizedKeys.keys = [ (builtins.readfile ./././.) ];
      extraGroups = [ "wheel" "video" "audio" ]
        ++ ifGroupsExist [ "network" "docker" "podman" "libvirtd" "git" ];
      packages = [ pkgs.home-manager ];
    };
  };
  programs.zsh.enable = true;

  home-manager.users.${user} =
    import ../../../home/${user}/${config.networking.hostName}.nix;

  sops.secrets.${user} = {
    sopsFile = ../../../secrets/accounts.yaml;
    neededForUsers = true;
  };
}
