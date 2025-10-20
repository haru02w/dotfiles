{
  lib,
  pkgs,
  ...
}:
with lib.nixvim; {
  lsp = {
    inlayHints.enable = true;
    servers = {
      # docker
      docker_compose_language_service.enable = true;
      dockerls.enable = true;
      # c/c++
      clangd = {
        enable = true;
        config.cmd = [
          "clangd"
          "--offset-encoding=utf-16"
        ];
      };
      cmake.enable = true;
      # clojure
      clojure_lsp.enable = true;
      # bash
      bashls.enable = true;
      # rust
      rust_analyzer.enable = true;
      # zig
      zls.enable = true;
      # web - html/css
      html.enable = true;
      cssls.enable = true;
      jsonls.enable = true;
      # java
      jdtls.enable = true;
      # typescript/javascript
      ts_ls.enable = true;
      # lua
      lua_ls.enable = true;
      # nix
      nixd.enable = true;
      nil_ls = {
        enable = true;
        config.nix.flake.autoArchive = true;
      };
      # markdown
      marksman.enable = true;
      # python
      basedpyright.enable = true;
      # go
      gopls.enable = true;
      # yaml
      yamlls.enable = true;
      # sql
      sqls.enable = true;
      # tailwind
      tailwindcss.enable = true;
      # nginx
      nginx_language_server.enable = true;
    };
    keymaps = [
      # diagnostic
      {
        key = "<leader>ld";
        action = mkRaw "function() vim.diagnostic.open_float() end";
        options.desc = "Show diagnostics in float";
      }
      {
        key = "[d";
        action = mkRaw "function() vim.diagnostic.goto_prev() end";
        options.desc = "Go to previous diagnostic";
      }
      {
        key = "]d";
        action = mkRaw "function() vim.diagnostic.goto_next() end";
        options.desc = "Go to next diagnostic";
      }

      # lspBuf
      {
        key = "gd";
        lspBufAction = "definition";
        options.desc = "Go to definition";
      }
      {
        key = "gD";
        lspBufAction = "references";
        options.desc = "List references";
      }
      {
        key = "gi";
        lspBufAction = "implementation";
        options.desc = "Go to implementation";
      }
      {
        key = "gt";
        lspBufAction = "type_definition";
        options.desc = "Go to type definition";
      }
      {
        key = "K";
        lspBufAction = "hover";
        options.desc = "Hover documentation";
      }
      {
        key = "<leader>li";
        lspBufAction = "incoming_calls";
        options.desc = "Incoming calls";
      }
      {
        key = "<leader>lo";
        lspBufAction = "outgoing_calls";
        options.desc = "Outgoing calls";
      }
      {
        key = "<leader>la";
        lspBufAction = "code_action";
        options.desc = "Code action";
      }
      {
        key = "<leader>lr";
        lspBufAction = "rename";
        options.desc = "Rename symbol";
      }
      {
        key = "<leader>lw";
        lspBufAction = "workspace_symbol";
        options.desc = "Search workspace symbols";
      }
      {
        key = "<leader>lf";
        lspBufAction = "format";
        options.desc = "Format document";
      }
    ];
  };
  plugins = {
    # lsp-format.enable = true;
    # JS/TS lsp
    typescript-tools.enable = true;
    # Flutter
    flutter-tools.enable = true;
  };
  # NOTE: maybe I won't use some of them
  extraPackages = with pkgs; [
    cargo
    rustc
    rustfmt
  ];
}
