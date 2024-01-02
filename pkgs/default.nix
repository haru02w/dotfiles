{ pkgs ? import <nixpkgs>{ } }:
{
  battop = pkgs.callPackage ./battop {};
  nvim-config = pkgs.callPackage ./nvim-config {};
}
