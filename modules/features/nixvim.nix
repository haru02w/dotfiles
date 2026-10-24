{
  den.aspects.nixvim = {
    nixos =
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

        config.environment.systemPackages = [
          config.nixvim.package
        ];
      };

    homeManager =
      {
        config,
        lib,
        self',
        osConfig ? null,
        ...
      }:
      {
        options.nixvim.package = lib.mkOption {
          type = lib.types.package;
          # Follow the host's choice when home-manager runs under NixOS.
          default = osConfig.nixvim.package or self'.packages.nixvim;
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
