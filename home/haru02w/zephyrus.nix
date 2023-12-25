{ inputs, outputs, lib, config, pkgs, ... }: 

{
  imports = [
    ./global
    ./features/desktop/hyprland
  ];

    # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;[
    firefox
    discord
    webcord
    #gpustat

    # status tools
    powertop
    btop
    htop
  ];
}
