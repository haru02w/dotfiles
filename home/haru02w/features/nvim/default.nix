{ pkgs, ...}:

{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs;[
    # # neovim config
    ripgrep
    fzf

    #tmux 
    tmux
  ];

  # neovim config
  home.file = {
    ".config/nvim" = {
      source = ../../dotconfig/nvim;
      recursive = true;
    };
    ".config/tmux" = {
      source = ../../dotconfig/tmux;
      recursive = true;
    };
  };
}
