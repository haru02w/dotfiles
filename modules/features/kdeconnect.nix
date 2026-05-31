{
  den.aspects.kdeconnect = {
    homeManager = {
      services.kdeconnect = {
        enable = true;
        indicator = true;
      };
    };
    nixos = _: {
      programs.kdeconnect.enable = true;
    };
  };
}
