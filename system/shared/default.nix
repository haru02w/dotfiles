{ inputs,config, pkgs, nixpkgs, ...}:

{
  imports = [ 
    ./desktop.nix 
    ./security.nix
  ];
  # System Packages. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    home-manager
  ];

  environment.sessionVariables = {
    EDITOR = "nvim";
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # Users
  users.users = {
    haru02w = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [];
    };
    # more
  };

#  ###############################
  # Enable network
  networking.networkmanager.enable = true;

  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;

  nix.gc = {
    automatic = true;
    dates = "*-*-* 17:00:00";
    options = "--delete-older-than 7d";
  };

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
