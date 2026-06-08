{
  inputs,
  lib,
  ...
}:
let
  mkStylix = pkgs: {
    enable = true;
    image = inputs.self.outPath + "/wallpapers/nix-wallpaper-binary-black_8k.png";
    polarity = "dark";
    # Preview themes: https://dt.iki.fi/base16-previews#oxocarbon-dark
    base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.open-sans;
        name = "Open Sans";
      };
      serif = {
        package = pkgs.roboto-serif;
        name = "Roboto Serif";
      };
      sizes = {
        desktop = 12;
        popups = 10;
        terminal = 14;
        applications = 12;
      };
    };
  };
in
{
  flake-file = {
    # No nixpkgs.follows: keep stylix pinned so nix-community.cachix.org hits.
    inputs.stylix.url = "github:nix-community/stylix";
    nixConfig = {
      extra-substituters = [ "https://nix-community.cachix.org" ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  den.aspects.stylix = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.stylix.nixosModules.stylix ];
        stylix = mkStylix pkgs;
      };

    homeManager =
      {
        pkgs,
        osConfig ? null,
        ...
      }:
      let
        managedByNixos = osConfig.stylix.enable or false;
      in
      {
        imports = lib.optional (!managedByNixos) inputs.stylix.homeModules.stylix;
        stylix = lib.mkIf (!managedByNixos) (mkStylix pkgs);
      };
  };
}
