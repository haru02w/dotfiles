{den, ...}: {
  den.aspects.haru02w = {
    includes = [
      den.batteries.primary-user
      (den.batteries.user-shell "zsh")
      den.aspects.stylix
    ];

    homeManager = _: {
    };

    provides.to-hosts.nixos = _: {
      users.users.haru02w.initialPassword = "changeme";
    };
  };
}
