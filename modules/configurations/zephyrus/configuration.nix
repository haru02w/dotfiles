{ den, ... }:
{
  den.aspects.zephyrus = {
    includes = [
      (den.batteries.vm-autologin "haru02w")
      den.aspects.desktop
      den.aspects.llama-cpp
      den.aspects.kanata
    ];
    nixos = { };
    provides.to-users.homeManager = _: { };
  };
}
