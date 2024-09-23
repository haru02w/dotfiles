{
  imports = [
    # treesitter
    ./treesitter/treesitter.nix # syntax highlight, folding, etc
    ./treesitter/treesitter-context.nix # show context of code when not visible
    ./treesitter/treesitter-textobjects.nix # select tokens based on the syntax

    # lsp
    ./lsp/lsp.nix
    ./lsp/none-ls.nix
    ./lsp/trouble.nix

    # cmp
    ./cmp/cmp.nix # TODO:

    ./flash.nix # TODO: fast navigation
    # BUG: ./harpoon.nix # fast file switcher
    ./grapple.nix # fast file switcher

    ./colorizer.nix # hex-color shows color
    ./comment-box.nix # create cool boxes for beautiful comments
    ./comment.nix # toggle comments
    ./undotree.nix # undo history tracker
    ./which-key.nix # show keys mapped
  ];
}
