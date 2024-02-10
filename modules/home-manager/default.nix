{ inputs, ... }: {
  flake-inputs = {
    imports = with inputs; [
      sops-nix.homeManagerModules.sops
      hyprland.homeManagerModules.default
    ];
  };
}
