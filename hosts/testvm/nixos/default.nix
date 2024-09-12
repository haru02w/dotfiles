{ pkgs, ... }: {
  imports = [ ./essentials.nix ];

  modules.settings = {
    enable = true;
    hostname = "testvm";
    keymap.layout = "us";
    locale = "en_US.UTF-8";
    timezone = "America/Sao_Paulo";
  };

  services.printing.enable = true;
  modules.programs.pipewire.enable = true;
  modules.displayManager.sddm.enable = true;
  modules.desktopEnvironment.plasma.enable = true;
  modules.fhsHelpers.enable = true;
  modules.programs.home-manager.enable = true;
  modules.programs.ssh = {
    enable = true;
    enablePassword = true;
    enableRootLogin = true;
  };

  environment.systemPackages = with pkgs; [ git neovim firefox home-manager ];

  modules.profile = "general";
  users.users.haru02w = {
    isNormalUser = true;
    initialPassword = "2003";
    description = "haru02w";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
