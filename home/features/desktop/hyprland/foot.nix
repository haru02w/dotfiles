{ config, pkgs, ... }:

{
	programs.foot = {
		enable = true;
		server.enable = true;
		settings = {
		  main = {
	        font = "FiraCode Nerd Font:size=16";
			dpi-aware = false;
		  };
		  cursor.color = "11121d a0a8cd";
		  colors = {
			foreground = "a0a8cd";
			background = "11121d";
			selection-foreground = "a0a8cd";
			selection-background = "11121d";

			regular0 = "06080a"; # black
			regular1 = "ee6d85"; # red
			regular2 = "95c561"; # green
			regular3 = "d7a65f"; # yellow
			regular4 = "7199ee"; # blue
			regular5 = "a485dd"; # purple
			regular6 = "38a89d"; # cyan
			regular7 = "a0a8cd"; # white

			bright0 = "212234"; # black
			bright1 = "ee6d85"; # red
			bright2 = "95c561"; # green
			bright3 = "d7a65f"; # yellow
			bright4 = "7199ee"; # blue
			bright5 = "a485dd"; # purple
			bright6 = "38a89d"; # cyan
			bright7 = "a0a8cd"; # white
		  };
		};
	};
}
