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
    ./cmp/cmp.nix # TODO:

    ./movement/flash.nix # TODO: fast navigation
    ./movement/grapple.nix # fast file switcher
    # BUG: ./movement/harpoon.nix # fast file switcher

    ./extra/colorizer.nix # hex-color shows color
    ./extra/comment-box.nix # create cool boxes for beautiful comments
    ./extra/comment.nix # toggle comments
    ./extra/undotree.nix # undo history tracker
    ./extra/which-key.nix # show keys mapped
  ];
}
