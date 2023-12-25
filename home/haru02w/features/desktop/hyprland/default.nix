
{ config, pkgs, inputs, ... }:

{
	home.packages = with pkgs; [
	  wl-clipboard
	  rofi-wayland
	  waybar
	  libnotify
	  brightnessctl
	  grimblast
	];

	services.mako = {
		enable = true;
		ignoreTimeout = true;
		defaultTimeout = 5000;
	};

	imports = [ 
	  inputs.hyprland.homeManagerModules.default
	  ./hyprland.nix
	  ./waybar.nix
	  ./rofi.nix
	  ./foot.nix
	];
}
