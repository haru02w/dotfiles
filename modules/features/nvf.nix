{
  den.aspects.nvf = {
    nixos =
      { self', ... }:
      {
        environment.systemPackages = [
          self'.packages.nvf
        ];
      };

    homeManager =
      { self', ... }:
      {
        home.sessionVariables = {
          EDITOR = "nvim";
        };
        home.packages = [
          self'.packages.nvf
        ];
      };
  };
}
