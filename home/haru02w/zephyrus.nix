{ inputs, outputs, lib, config, pkgs, ... }: 

{
  imports = [
    ../features/common/global.nix
    ../features/desktop/hyprland
    ../features/gui-packages.nix
  ];

  home.packages = with pkgs; [

  ];
}
