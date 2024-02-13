{
  flake-inputs = { inputs, ... }: {
    imports = with inputs; [
      sops-nix.homeManagerModules.sops
      hyprland.homeManagerModules.default
      impermanence.nixosModules.home-manager.impermanence
      nix-colors.homeManagerModules.default
    ];
  };
  wallpaper = {lib,...}:{
    options.wallpaper = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      example = ../image.jpg;
    };
  };
}
