{
  config,
  pkgs,
  ...
}: {
  # Sops
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/haru02w/.config/sops/age/keys.txt";
    secrets.haru02w = {
      sopsFile = ../../../secrets/secrets.yaml;
      neededForUsers = true;
    };
  };

  # Users 
  users.mutableUsers = false; # Disable imperative passwords
  users.users = let
    ifGroupsExist = groups:
      builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  in {
    root.hashedPasswordFile = "!"; # Disable root login
    haru02w = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.haru02w.path;
      extraGroups = ifGroupsExist [
        "wheel"
        "input"
        "video"
        "audio"
        "docker"
        "networkmanager"
        "lp"
        "libvirtd"
        "git"
        "kvm"
      ];
      packages = with pkgs; [
      ];
    };
  };
}
