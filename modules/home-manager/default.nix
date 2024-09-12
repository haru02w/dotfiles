{lib, ...}:
with lib; {
  imports = [
    ./global/settings.nix
    ./global/nix.nix
    sops-nix.homeManagerModules.sops
  ];
}
