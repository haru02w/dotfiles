{
  inputs,
  lib,
  ...
}:
{
  options.perSystem = inputs.flake-parts.lib.mkPerSystemOption (
    { ... }:
    {
      options.nixvim.module = lib.mkOption {
        type = lib.types.deferredModule;
        default = { };
        description = "nixvim module merged across files and passed to makeNixvimWithModule.";
      };
    }
  );

  config = {
    flake-file.inputs.nixvim.url = "github:nix-community/nixvim";

    perSystem =
      {
        pkgs,
        system,
        config,
        ...
      }:
      {
        packages.nixvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
          inherit pkgs;
          module = config.nixvim.module;
        };
      };
  };
}
