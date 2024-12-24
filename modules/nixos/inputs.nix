{inputs, ...}: {
  imports = with inputs; [
    disko.nixosModules.disko
    sops-nix.nixosModules.sops
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
  ];
}
