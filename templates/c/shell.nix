{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  packages = with pkgs; [
    gcc
	  gnumake
	  cmake
  ];
  shellHook = ''
    echo "C/C++ development shell loaded."
  '';
}
