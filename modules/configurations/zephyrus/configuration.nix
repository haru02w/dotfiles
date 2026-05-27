{den, ...}: {
  den.aspects.zephyrus = {
    includes = [
      (den.batteries.vm-autologin "haru02w")
      den.aspects.desktop
    ];
    nixos = {};
    provides.to-users.homeManager = _: {};
  };
}
