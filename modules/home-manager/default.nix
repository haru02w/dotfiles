{
  flake-inputs = { inputs, ... }: {
    imports = with inputs; [
      sops-nix.homeManagerModules.sops

      # ./global/settings.nix
      # ./global/nix.nix
    ];
  };
}
