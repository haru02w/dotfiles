{ inputs, pkgs, ... }: {
  home = {
    packages = [ inputs.nixnvc.packages.${pkgs.system}.default ];
    sessionVariables.EDITOR = "nvim";
  };
}
