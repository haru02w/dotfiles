{
  lib,
  pkgs,
  ...
}:
with lib.nixvim; {
  colorschemes.base16 = {
    enable = true;
    colorscheme = lib.mkDefault "tokyo-night-dark";
  };

  performance = {
    byteCompileLua = {
      enable = true;
      nvimRuntime = true;
      configs = true;
      plugins = true;
    };
  };

  clipboard = {
    # Use system clipboard
    register = "unnamedplus";
    providers = {
      wl-copy = {
        enable = true;
        package = pkgs.wl-clipboard;
      };
    };
  };

  diagnostics = {
    update_in_insert = true;
    severity_sort = true;
    float.border = "rounded";
    jump.severity = mkRaw "vim.diagnostic.severity.WARN";
  };

  autoCmd = [
    {
      callback = mkRaw "function() vim.highlight.on_yank({timeout=500}) end";
      event = "TextYankPost";
      pattern = "*";
    }
    {
      event = ["FileType"];
      pattern = "TelescopePrompt";
      command = "inoremap <buffer><silent> <ESC> <ESC>:close!<CR>";
    }
  ];
}
