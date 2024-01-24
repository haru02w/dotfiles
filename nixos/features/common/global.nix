{ pkgs, ... }: {
  imports = [
    ../nix.nix
    ../udisk2.nix
    ../locale_n_timezone.nix
  ];
  environment.variables.EDITOR = "nvim";
  environment.systemPackages = with pkgs; [ neovim git wget ];

  programs.zsh.enable = true;
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "23.11";
  hardware.enableRedistributableFirmware = true;

  boot.supportedFilesystems = [ "ntfs" ];
}
