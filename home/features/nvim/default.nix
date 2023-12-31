{ pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  home.packages = with pkgs;[
    # # neovim config
    ripgrep
    fzf

  ];

  # neovim config
  home.file = {
    ".config/nvim" = {
      source = ../dotconfig/nvim;
      recursive = true;
    };
  };
}
