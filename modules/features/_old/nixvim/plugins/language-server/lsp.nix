{ den, ... }: {
  den.aspects.nixvim.homeManager = { lib, ... }: with lib.nixvim; {
    programs.nixvim = {
      lsp = {
        inlayHints.enable = true;
        servers = {
          "*" = {
            enable = true;
            config.capabilities = mkRaw "vim.lsp.protocol.make_client_capabilities()";
          };
          # Ansible
          ansiblels.enable = true;
          # Arduino
          arduino_language_server.enable = true;
          # assembly
          asm_lsp.enable = true;
          # Bash
          bashls.enable = true;
          # C/C++
          clangd.enable = true;
          # Clojure
          clojure_lsp.enable = true;
          # Cmake
          cmake.enable = true;
          # CSS
          cssls.enable = true;
          tailwindcss.enable = true;
          # C#
          # NOTE: separate plugin
          # Dart (Flutter)
          # NOTE: separate plugin
          # docker
          docker_language_server.enable = true;
          # Elixir
          expert.enable = true;
          # elixirls.enable = true;
          # Emmet
          emmet_ls.enable = true;
          # Gitlab CI
          gitlab_ci_ls.enable = true;
          # GLSL
          glsl_analyzer.enable = true;
          # Golang
          gopls.enable = true;
          # Haskell
          # NOTE: separate plugin
          # Helm
          helm_ls.enable = true;
          # HTML
          # html.enable = true;
          superhtml.enable = true;
          # Java
          jdtls.enable = true;
          # JSON
          jsonls.enable = true;
          # Kotlin
          kotlin_language_server.enable = true;
          # Lua
          lua_ls.enable = true;
          # Markdown
          marksman.enable = true;
          # nginx
          nginx_language_server.enable = true;
          # Nim
          nimls.enable = true;
          # Nix
          nixd.enable = true;
          statix.enable = true;
          # PHP
          phpactor.enable = true;
          # Powershell
          powershell_es.enable = true;
          # Python
          basedpyright.enable = true;
          ruff.enable = true;
          ##pylsp.enable = true;
          # Rust
          rust_analyzer.enable = true;
          # SQL
          sqls.enable = true;
          # Terraform
          terraformls.enable = true;
          # Typescript/Javascript
          # NOTE: separate plugin
          # XML
          lemminx.enable = true;
          # Yaml
          yamlls.enable = true;
          # Zig
          zls.enable = true;
        };
        keymaps = [
          # diagnostic
          {
            key = "<leader>ld";
            mode = "n";
            action = mkRaw "function() vim.diagnostic.open_float() end";
            options.desc = "Show diagnostics in float";
          }
          {
            key = "[d";
            mode = "n";
            action = mkRaw "function() vim.diagnostic.goto_prev() end";
            options.desc = "Go to previous diagnostic";
          }
          {
            key = "]d";
            mode = "n";
            action = mkRaw "function() vim.diagnostic.goto_next() end";
            options.desc = "Go to next diagnostic";
          }
          {
            key = "gd";
            mode = "n";
            lspBufAction = "definition";
            options.desc = "Go to definition";
          }
          {
            key = "gO";
            mode = "n";
            lspBufAction = "document_symbol";
            options.desc = "Go to document symbols";
          }
          {
            key = "gr";
            mode = "n";
            lspBufAction = "references";
            options.desc = "List references";
          }
          {
            key = "gI";
            mode = "n";
            lspBufAction = "implementation";
            options.desc = "Go to implementation";
          }
          {
            key = "gt";
            mode = "n";
            lspBufAction = "type_definition";
            options.desc = "Go to type definition";
          }
          {
            key = "K";
            mode = "n";
            lspBufAction = "hover";
            options.desc = "Hover documentation";
          }
          {
            key = "gK";
            mode = "n";
            lspBufAction = "signature_help";
            options.desc = "Signature help";
          }
          {
            key = "<leader>li";
            mode = "n";
            lspBufAction = "incoming_calls";
            options.desc = "Incoming calls";
          }
          {
            key = "<leader>lo";
            mode = "n";
            lspBufAction = "outgoing_calls";
            options.desc = "Outgoing calls";
          }
          {
            key = "<leader>la";
            mode = "n";
            lspBufAction = "code_action";
            options.desc = "Code action";
          }
          {
            key = "<leader>lr";
            mode = "n";
            lspBufAction = "rename";
            options.desc = "Rename symbol";
          }
          {
            key = "<leader>lw";
            mode = "n";
            lspBufAction = "workspace_symbol";
            options.desc = "Search workspace symbols";
          }
          {
            key = "<leader>lf";
            mode = "n";
            lspBufAction = "format";
            options.desc = "Format document";
          }
          {
            mode = "n";
            key = "<leader>ll";
            action = mkRaw "require('nvim-navbuddy').open";
            options.desc = "Open LSP NavBuddy";
          }
        ];
      };
      plugins = {
        # LSP icons
        lspkind.enable = true;
        # LSP configurations
        lspconfig.enable = true;
        # LSP overview
        navbuddy = {
          enable = true;
          settings.lsp.auto_attach = true;
        };
        # C#
        roslyn = {
          enable = true;
          settings = {
            broad_search = true;
            lock_target = true;
            silent = true;
          };
        };
        # Dart (Flutter)
        flutter-tools = {
          enable = true;
          settings = {
            closing_tags.enabled = true;
            decorations.statusline = {
              app_version = true;
              device = true;
            };
            dev_tools = {
              auto_open_browser = true;
              autostart = true;
            };
            widget_guides.enabled = true;
          };
        };
        # Haskell
        haskell-tools.enable = true;
        # Typescript
        typescript-tools.enable = true;
      };
      # TODO: iron.nvim
    };
  };
}
