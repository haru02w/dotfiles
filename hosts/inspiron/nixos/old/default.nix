{ pkgs, ... }: {
  imports = [
    ./disko.nix 
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  modules.settings = {
    hostname = "inspiron";
    keymap.layout = "us";
    locale = "en_US.UTF-8";
    timezone = "America/Sao_Paulo";
  };

  services.printing.enable = true;
  modules.programs.pipewire.enable = true;
  modules.displayManager.sddm.enable = true;
  modules.desktopEnvironment.plasma.enable = true;
  modules.fhsHelpers.enable = true;
  modules.programs.ssh = {
    enable = true;
    enablePassword = true;
    enableRootLogin = true;
  };

  environment.nix-persist = {
    enable = true;
    path = "/persist/system";
  };

  environment.systemPackages = with pkgs; [ git neovim firefox home-manager ];

  users.users.haru02w = {
    isNormalUser = true;
    description = "haru02w";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "24.05";
}
