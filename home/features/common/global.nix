# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, pkgs, config, outputs, ... }:

{
  imports = [
    ../nix.nix
    ../zsh.nix
    ../tmux.nix
    ../fonts.nix
    ../nvim.nix
    ../git.nix
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  home.packages = with pkgs;[
    libqalculate # calculator
    ncdu # tui disk usage analizer
    pulsemixer # tui pulse mixer 
    powertop # power status
    btop # general system status
	  htop # general system status
	  neofetch # system info
    pfetch #system info
  ];

  home = {
    username = lib.mkDefault "haru02w";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.11";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # let home-manager manage itself
  programs.home-manager.enable = true;
}
