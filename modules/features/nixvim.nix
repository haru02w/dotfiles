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
      {
        config,
        lib,
        self',
        ...
      }:
      {
        # Lets a host swap in a variant, e.g. `self'.packages.nixvim.extend { … }`
        options.nixvim.package = lib.mkOption {
          type = lib.types.package;
          default = self'.packages.nixvim;
          description = "Neovim (nixvim) package to install.";
        };

        config = {
          home.sessionVariables = {
            EDITOR = "nvim";
          };
          home.packages = [
            config.nixvim.package
          ];
        };
      };
  };
}
