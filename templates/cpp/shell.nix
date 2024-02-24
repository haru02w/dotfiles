{ pkgs ? import <nixpkgs> {}}:
let
  mainPkg = pkgs.callPackage ./default.nix {};
in
mainPkg.overrideAttrs (oa: {
  nativeBuildInputs = [
    # whatever you want more
  ] ++ (oa.nativeBuildInputs or [ ]);
})
