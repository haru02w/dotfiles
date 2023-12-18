{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
	  networkmanager_dmenu
	  rofi-wayland
	  waybar
	  mako
	  libnotify
      alacritty
	];

	imports = [ 
	  ./hyprland.nix
	  ./waybar.nix
	  ./rofi.nix
	];
}
