{ config, lib, pkgs, ...}:

{
  # System Packages. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    home-manager

    waybar
    mako
    libnotify
    kitty # allacritty later
    rofi-wayland
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
  };

  # Enable pipewire
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

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


  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
