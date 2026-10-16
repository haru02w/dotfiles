{
  den.aspects.vial = {
    nixos =
      { pkgs, ... }:
      {
        hardware.keyboard.qmk.enable = true;
        services.udev.packages = [ pkgs.vial ];
      };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.vial ];
      };
  };
}
