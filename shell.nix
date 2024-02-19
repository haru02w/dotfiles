{ pkgs ? import <nixpkgs>{}, ... }:
pkgs.mkShell {
  packages = with pkgs;[
    git
  ];

  shellHook = ''
    ${pkgs.git}/bin/git status
  '';
}
