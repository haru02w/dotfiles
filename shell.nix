{ pkgs, ... }:
pkgs.mkShell {
  shellHook = ''
    git status
  '';
}
