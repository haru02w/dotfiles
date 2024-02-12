{ outputs, pkgs, ... }: {
  imports = (builtins.attrValues outputs.nixosModules)
    ++ [ ./nix.nix ./openssh.nix ./security.nix ./home-manager.nix ];

  security.sudo.wheelNeedsPassword = false;

  environment = {
    variables.EDITOR = "nvim";
    systemPackages = with pkgs; [ neovim git wget ];
  };

  system.stateVersion = "23.11";
  hardware.enableRedistributableFirmware = true;
}
