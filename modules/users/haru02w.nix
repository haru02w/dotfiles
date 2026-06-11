{ den, ... }:
{
  den.aspects.haru02w = {
    includes = [
      den.batteries.primary-user
      den.batteries.host-aspects
      (den.batteries.user-shell "zsh")
    ];

    homeManager =
      { pkgs, ... }:
      {
        # temp
        home.packages = with pkgs; [
          neovim
          claude-code
        ];
      };

    provides.to-hosts.nixos = _: {
      users.users.haru02w.extraGroups = [
        "input"
        "docker"
        "libvirtd"
      ];
    };
  };
}
