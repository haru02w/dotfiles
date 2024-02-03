{ inputs, config, pkgs, lib,  ...}:
let
  ifGroupsExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  hasOptinPersistence = config.environment.persistence ? "/persist";
in
{
  imports = [
    ./hm-module.nix
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    age.keyFile = "${lib.optionalString hasOptinPersistence "/persist"}/${config.users.users.${config.users.main_user}.home}/.config/sops/age/keys.txt";
    secrets.${config.users.main_user} = {
      sopsFile = ../../secrets/accounts.yaml;
      neededForUsers = true;
    };
  };
  # disable `useradd`, `groupadd`, `usermod`, `passwd` commands
  users.mutableUsers = false; 
  users.users = {
    "${config.users.main_user}" = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.${config.users.main_user}.path;
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
  home-manager.users.${config.users.main_user} =
    import ../../home/${config.users.main_user}/${config.networking.hostName}.nix;
}
