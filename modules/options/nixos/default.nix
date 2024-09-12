{inputs, ...}: {
  imports = with inputs; [
    disko.nixosModules.disko
    sops-nix.nixosModules.sops
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
    nix-persist.nixosModules.nix-persist

    ./profiles.nix
    ./global/settings.nix
    ./global/nix.nix
    ./global/security.nix
    ./programs/docker.nix
    ./programs/neovim.nix
    ./programs/pipewire.nix
    ./programs/ssh.nix
    ./programs/fhsHelpers.nix
    ./programs/home-manager.nix
    ./desktops/desktopEnvironment.nix
    ./desktops/displayManager.nix
  ];
}
