{ inputs, outputs, lib, config, pkgs, ... }: 

{
  imports = [
    ./global
    ./features/desktop/hyprland
    ../features/pkgs_gui.nix
    ../features/pkgs_cli.nix
  ];
}
