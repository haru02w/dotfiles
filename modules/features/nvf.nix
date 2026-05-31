{ inputs, ... }:
{
  den.aspects.nvf = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.nvf
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        home.sessionVariables = {
          EDITOR = "nvim";
        };
        home.packages = [
          inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.nvf
        ];
      };
  };
}
