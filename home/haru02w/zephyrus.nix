{ inputs, outputs, lib, config, pkgs, ... }: 

{
  imports = [
    ./global
    ./features/desktop/hyprland
    ../segments/pkgs_gui.nix
    ../segments/pkgs_cli.nix
  ];
}
