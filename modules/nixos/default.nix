{
  flake-inputs = { inputs, ... }: {
    imports = with inputs; [
      disko.nixosModules.disko
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
      stylix.nixosModules.stylix
      nix-persist.nixosModules.nix-persist

      ./presets
      ./desktops
      ./desktops
      ./programs
      ./settings
    ];
  };
}
