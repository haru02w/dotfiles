{
  inputs,
  den,
  lib,
  ...
}:
{
  flake-file.inputs.nixos-wsl = {
    url = "github:nix-community/NixOS-WSL";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects."zephyrus-wsl" = {
    includes = [ den.aspects.headless ];

    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.nixos-wsl.nixosModules.default ];

        wsl = {
          enable = true;
          defaultUser = "haru02w";
        };

        # WSL manages networking itself
        networking.networkmanager.enable = lib.mkForce false;

        # No display server / login manager in WSL
        services.openssh.enable = lib.mkForce false;
      };

    provides.to-users.homeManager = _: { };
  };
}
