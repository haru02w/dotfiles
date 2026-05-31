{ den, ... }:
{
  den.aspects.neovim.nixos =
    { pkgs, ... }:
    {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        configure.customRC = ''
          set number relativenumber
        '';
      };
      environment.systemPackages = [ pkgs.neovim ];
      environment.sessionVariables = {
        EDITOR = "nvim";
      };
    };
}
