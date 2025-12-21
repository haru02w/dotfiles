{
  # Loads the content of the file into the environment variable
  extraConfigLua = ''
    local function load_key_to_env(path, env_var)
      local expanded_path = vim.fn.expand(path)
      local f = io.open(expanded_path, "r")
      if f then
        local key = f:read("*all"):gsub("%s+", "")
        f:close()
        vim.fn.setenv(env_var, key)
      end
    end

    -- Load your key into the environment variable
    load_key_to_env("~/.config/openrouter-api.key", "OPENROUTER_API_KEY")
  '';

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
    ./language-server/codecompanion.nix
    ./language-server/minuet-ai.nix
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
    ./ui/noice.nix
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
