{
  imports = [
    # treesitter
    ./treesitter/treesitter.nix # syntax highlight, folding, etc
    ./treesitter/treesitter-context.nix # show context of code when not visible
    ./treesitter/treesitter-textobjects.nix # select tokens based on the syntax
    ./treesitter/ts-autotag.nix # auto-close html tags

    # lsp
    ./lsp/lsp.nix
    ./lsp/none-ls.nix
    ./lsp/trouble.nix # TODO:

    # cmp
    ./cmp/autopairs.nix # add closing chars automatically
    ./cmp/cmp.nix # completion
    ./cmp/luasnip.nix # snippets
    ./cmp/lspkind.nix # cool icons

    # dap
    ./dap/dap.nix

    # movement
    ./movement/flash.nix # TODO: fast navigation
    ./movement/grapple.nix # fast file switcher (harpoon alternative)
    # BUG: ./movement/harpoon.nix # fast file switcher

    # ui
    ./ui/lualine.nix # line
    ./ui/alpha.nix
    ./ui/dressing.nix
    ./ui/indent-blankline.nix
    #./ui/noice.nix
    ./ui/precognition.nix
    ./ui/smart-splits.nix
    ./ui/web-devicons.nix
    ./ui/todo-comments.nix
    ./ui/guess-indent.nix

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
    ./extra/hardtime.nix # enforce good pratices
    ./extra/presence.nix # discord presence
  ];
}
