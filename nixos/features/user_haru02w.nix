{ inputs, config, pkgs, ...}:
let
  default-user = "haru02w";
  ifGroupsExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [
    ./hm-module.nix
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    age.keyFile = "${config.users.users.${default-user}.home}/.config/sops/age/keys.txt";
    secrets.${default-user} = {
      sopsFile = ../../secrets/accounts.yaml;
      neededForUsers = true;
    };
  };
  # disable `useradd`, `groupadd`, `usermod`, `passwd` commands
  users.mutableUsers = false; 
  users.users = {
    "${default-user}" = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.${default-user}.path;
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
  home-manager.users.${default-user} =
    import ../../home/${default-user}/${config.networking.hostName}.nix;
}
