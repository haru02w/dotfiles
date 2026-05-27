{inputs, ...}: {
  flake-file.inputs.stylix.url = "github:nix-community/stylix";

  den.aspects.stylix.nixos = {
    imports = [inputs.stylix.nixosModules.stylix];
    stylix.enable = true;
  };
}
