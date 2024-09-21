{
  imports = [
    # treesitter
    ./treesitter.nix # syntax highlight, folding, etc
    ./treesitter-context.nix # show context of code when not visible
    ./treesitter-textobjects.nix # select tokens based on the syntax
    ./cmp.nix # completion
    ./flash.nix # TODO: fast navigation
    # BUG: ./harpoon.nix # project file manager
    ./grapple.nix

    ./colorizer.nix # hex-color shows color
    ./comment-box.nix # create cool boxes for beautiful comments
    ./comment.nix # toggle comments
    ./undotree.nix # undo history tracker
    ./which-key.nix # show keys mapped
  ];
}
