{
  flake-inputs = { inputs, ... }: {
    imports = with inputs; [
      sops-nix.homeManagerModules.sops
      hyprland.homeManagerModules.default
      impermanence.nixosModules.home-manager.impermanence
      stylix.homeManagerModules.stylix
    ];
  };
}
