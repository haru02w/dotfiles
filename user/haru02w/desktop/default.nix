{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
	  rofi-wayland
	  waybar
	  mako
	  libnotify
	  brightnessctl
	  grimblast
	];

	imports = [ 
	  ./hyprland.nix
	  ./waybar.nix
	  ./rofi.nix
	  ./foot.nix
	];
}
