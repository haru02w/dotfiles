{pkgs, ...}:
{
  imports = [
    ../nix.nix
    ../hm-module.nix
    ../locale_n_timezone.nix
  ];
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
  ];
  hardware.enableRedistributableFirmware = true;
}
