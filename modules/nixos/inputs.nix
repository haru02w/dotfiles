{inputs, ...}: {
  imports = with inputs; [
    nixos-wsl.nixosModules.default
    disko.nixosModules.disko
    sops-nix.nixosModules.sops
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
  ];
}
