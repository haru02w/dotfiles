{ inputs, config, pkgs, lib,  ...}:
let
  user = "haru02w";
  ifGroupsExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  hasOptinPersistence = (config.environment ? persistence) && (config.environment.persistence ? "/persist");
in
{
  imports = [
    ../hm-module.nix
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    age.keyFile = "${lib.optionalString hasOptinPersistence "/persist"}/${config.users.users.${user}.home}/.config/sops/age/keys.txt";
    secrets.${user} = {
      sopsFile = ../../../secrets/accounts.yaml;
      neededForUsers = true;
    };
  };
  # disable `useradd`, `groupadd`, `usermod`, `passwd` commands
  users.mutableUsers = false; 
  users.users = {
    "${user}" = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.${user}.path;
      extraGroups = ifGroupsExist [
        "wheel" # Enable ‘sudo’ for the user.
        "networkmanager"
        "video"
        "audio"
        "libvirtd"
        "network"
        "git"
      ];
      shell = pkgs.zsh;
      packages = [ ];
    };
    root.hashedPassword = "!";
    # more
  };
  home-manager.users.${user} =
    import ../../../home/${user}/${config.networking.hostName}.nix;
}
