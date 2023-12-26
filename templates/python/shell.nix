{ pkgs ? import <nixpkgs> {} }:
let
  python-env = pkgs.python3.withPackages (pp: with pp;[
    numpy
  ]);
in
pkgs.mkShell {
  packages = with pkgs; [
    
  ] ++ [ python-env ];

  shellHook = ''
    if [[ ! -d .venv ]]; then
      echo "No virtual env found at ./.venv, creating a new virtual env with Nix"
      ${python-env}/bin/python -m venv .venv
    fi
    source .venv/bin/activate
    echo "python development shell loaded."
  '';
}
