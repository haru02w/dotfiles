{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
	  networkmanager_dmenu
	  waybar
	  mako
	  libnotify
      alacritty
	  rofi-wayland
	];

	imports = [ 
	  ./hyprland.nix
	  ./waybar.nix
	];
}
