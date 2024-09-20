{ lib, pkgs, ... }:
with lib.nixvim; {

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
      event = [ "FileType" ];
      pattern = "TelescopePrompt";
      command = "inoremap <buffer><silent> <ESC> <ESC>:close!<CR>";
    }
    {
      event = "FileType";
      pattern = [ "tex" "latex" "markdown" ];
      command = "setlocal spell spelllang=en,fr";
    }
  ];
}
