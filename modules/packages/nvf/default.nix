{
  inputs,
  lib,
  ...
}:
{
  options.perSystem = inputs.flake-parts.lib.mkPerSystemOption (
    { ... }:
    {
      options.nvf.module = lib.mkOption {
        type = lib.types.deferredModule;
        default = { };
        description = "nvf module merged across files and passed to neovimConfiguration.";
      };
    }
  );

  config = {
    flake-file.inputs.nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    perSystem =
      {
        pkgs,
        config,
        ...
      }:
      {
        packages.nvf =
          (inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [ config.nvf.module ];
          }).neovim;
      };
  };
}
