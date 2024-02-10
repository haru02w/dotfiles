{ inputs, ... }: {
  flake-inputs = {
    imports = with inputs; [
      impermanence.nixosModules.impermanence
      disko.nixosModules.disko
      home-manager.nixosModules.home-manager
    ];
  };
}
