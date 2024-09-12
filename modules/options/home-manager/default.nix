{lib, ...}:
with lib; {
  imports = [
    ./profiles.nix
    ./global/settings.nix
    ./global/nix.nix
    sops-nix.homeManagerModules.sops
  ];
}
