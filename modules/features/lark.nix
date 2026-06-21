{
  # No nixpkgs.follows: keep lark-nix pinned so lark-nix.cachix.org hits.
  flake-file.inputs.lark-nix.url = "github:bintis/lark-nix";

  flake-file.nixConfig = {
    extra-substituters = [ "https://lark-nix.cachix.org" ];
    extra-trusted-public-keys = [
      "lark-nix.cachix.org-1:l44MeIXQqzYeuz3NDq8JzBcMCdD4KCRAM9Q99miHl5w="
    ];
  };

  den.aspects.lark.homeManager =
    { inputs', ... }:
    {
      home.packages = [ inputs'.lark-nix.packages.default ];
    };
}
