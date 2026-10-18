{
  den.aspects.nixvim = {
    nixos =
      { self', ... }:
      {
        environment.systemPackages = [
          self'.packages.nixvim
        ];
      };

    homeManager =
      { self', ... }:
      {
        home.sessionVariables = {
          EDITOR = "nvim";
        };
        home.packages = [
          self'.packages.nixvim
        ];
      };
  };
}
