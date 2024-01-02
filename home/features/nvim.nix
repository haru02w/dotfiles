{pkgs, ...}:
{
  home.packages = with pkgs;[
    nixnvc
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
