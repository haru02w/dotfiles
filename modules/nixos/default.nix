{
  flake-inputs = { inputs, ... }: {
    imports = with inputs; [
      impermanence.nixosModules.impermanence
      disko.nixosModules.disko
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
      stylix.nixosModules.stylix
    ];
  };
}
