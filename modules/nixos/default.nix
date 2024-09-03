{ inputs, ylib, ... }: {
  imports = with inputs;
    [
      disko.nixosModules.disko
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
      nix-persist.nixosModules.nix-persist
    ] ++ (ylib.umport {
      path = [ ./. ];
      recursive = true;
    });
}
