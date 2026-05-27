{den, ...}: {
  den.aspects.desktop = {
    includes = [
      den.aspects.headless
      den.aspects.pipewire
      den.aspects.playerctld
      den.aspects.plymouth
      den.aspects.ly
      den.aspects.udiskie
      den.aspects.virt-manager
      den.aspects.kdeconnect
    ];

    nixos = _: {};
    homeManager = _: {};
  };
}
