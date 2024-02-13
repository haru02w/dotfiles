{
  flake-inputs = { inputs, ... }: {
    imports = with inputs; [
      sops-nix.homeManagerModules.sops
      hyprland.homeManagerModules.default
      impermanence.nixosModules.home-manager.impermanence
      nix-colors.homeManagerModules.default
    ];
  };
  wallpaper = import ./theme.nix;
}
