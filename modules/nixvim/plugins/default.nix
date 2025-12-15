{
  imports = [
    # treesitter
    ./treesitter/treesitter.nix
    ./treesitter/treesitter-textobjects.nix
    ./treesitter/treesj.nix
    ./treesitter/autopairs.nix
    # lsp # TODO: review other plugins for integrations with lsp and cmp
    ./language-server/lsp.nix
    ./language-server/blink-cmp.nix
    ./language-server/none-ls.nix
    ./language-server/trouble.nix
    # movement
    ./movement/flash.nix
    ./movement/harpoon.nix
    ./movement/navigator.nix
    ./movement/yazi.nix
    # ui
    ./ui/fidget.nix
    ./ui/colorizer.nix
    ./ui/which-key.nix
    ./ui/lualine.nix
    ./ui/todo-comments.nix
    ./ui/quicker.nix
    # extra
    ./extra/comment.nix
    ./extra/gitsigns.nix
    ./extra/hex.nix
    ./extra/indent-o-matic.nix
    ./extra/mini.nix
    ./extra/presence.nix
    ./extra/snacks.nix
    ./extra/ufo.nix
    ./extra/undotree.nix
    ./extra/which-key.nix
  ];
}
