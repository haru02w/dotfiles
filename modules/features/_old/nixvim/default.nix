{ den, ... }:
{
  flake-file.inputs.nixvim.url = "github:nix-community/nixvim";

  den.aspects.nixvim.homeManager =
    { inputs, ... }:
    {
      imports = [ inputs.nixvim.homeManagerModules.nixvim ];
      programs.nixvim.enable = true;
    };
}
