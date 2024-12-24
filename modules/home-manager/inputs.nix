{inputs, ...}: {
  imports = with inputs; [
    sops-nix.homeManagerModules.sops
  ];
}
