{pkgs ? import <nixpkgs>{ } }:
{
  battop = pkgs.callPackage ./battop {};
}
