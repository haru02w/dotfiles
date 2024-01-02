{inputs, pkgs, ...}:
{
  home.packages = [
    inputs.nixnvc.packages.${pkgs.system}.nvim
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
