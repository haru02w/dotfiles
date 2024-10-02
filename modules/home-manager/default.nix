{
  flake-inputs = {inputs, ...}: {
    imports = with inputs; [
      sops-nix.homeManagerModules.sops

      ./settings
      ./programs
      ./presets
    ];
  };
}
