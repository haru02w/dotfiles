{ lib, pkgs, outputs, ...}:{
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" "repl-flake" ];
  };
}
