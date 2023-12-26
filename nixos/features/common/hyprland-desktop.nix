{
  imports = [ 
    ../hyprland.nix
	  ../opengl.nix 
    ../pipewire.nix
    ../fonts.nix
  ];

  programs.dconf.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
