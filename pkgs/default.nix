{inputs, pkgs ? import <nixpkgs> { }}: {
  battop = pkgs.callPackage ./battop {};
  disko = inputs.disko.packages.${pkgs.system}.default;
}
