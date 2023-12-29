{pkgs, ...}:
{
  imports = [
    ../nix.nix
    ../hm-module.nix
    ../locale_n_timezone.nix
  ];
  environment.variables.EDITOR = "nvim";
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
  ];

  programs.zsh.enable = true;

  system.stateVersion = "23.11";
  hardware.enableRedistributableFirmware = true;
}
