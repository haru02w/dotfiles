{pkgs, outputs, ...}:{
  imports = [
    (builtins.attrValues outputs.nixosModules)
    ./disko.nix
  ];
}
