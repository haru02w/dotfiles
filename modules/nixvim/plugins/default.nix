{
  imports = [
    # treesitter
    ./treesitter/treesitter.nix # syntax highlight, folding, etc
    ./treesitter/treesitter-context.nix # show context of code when not visible
    ./treesitter/treesitter-textobjects.nix # select tokens based on the syntax

    # lsp
    ./lsp/lsp.nix
    ./lsp/none-ls.nix
    ./lsp/trouble.nix # TODO:

    # cmp
    ./cmp/cmp.nix
    ./cmp/lspkind.nix

    ./movement/flash.nix # TODO: fast navigation
    ./movement/grapple.nix # fast file switcher
    # BUG: ./movement/harpoon.nix # fast file switcher

    # ui
    ./ui/lualine.nix
    ./ui/alpha.nix
    ./ui/dressing.nix
    ./ui/indent-blankline.nix
    ./ui/noice.nix
    ./ui/precognition.nix
    ./ui/smart-splits.nix

    # extra
    ./extra/colorizer.nix # hex-color shows color
    ./extra/comment-box.nix # create cool boxes for beautiful comments
    ./extra/comment.nix # toggle comments
    ./extra/undotree.nix # undo history tracker
    ./extra/which-key.nix # show keys mapped
    ./extra/telescope.nix # fuzzy find
    ./extra/illuminate.nix # illuminate cursor words
    ./extra/marksview.nix # Markdown viewer
    ./extra/oil.nix # file manager
    ./extra/spectre.nix # search replace workdir
    ./extra/ufo.nix # folding
  ];
}
