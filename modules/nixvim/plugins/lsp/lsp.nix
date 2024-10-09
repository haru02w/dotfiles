{
  plugins = {
    lsp-format.enable = true;
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        # docker
        docker_compose_language_service.enable = true;
        dockerls.enable = true;
        # c/c++
        clangd = {
          enable = true;
          cmd = ["clangd" "--offset-encoding=utf-16"];
        };
        cmake.enable = true;
        # bash
        bashls.enable = true;
        # rust
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        # zig
        zls.enable = true;
        # web - html/css
        html.enable = true;
        cssls.enable = true;
        # java
        jdtls.enable = true;
        # lua
        lua_ls.enable = true;
        # nix
        nixd.enable = true;
        nil_ls = {
          enable = true;
          settings.nix.flake.autoArchive = true;
        };
        # markdown
        marksman.enable = true;
        # python
        pyright.enable = true;
        # go
        gopls.enable = true;
        # yaml
        yamlls.enable = true;
        # sql
        sqls.enable = true;
      };
      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>ld" = {
            action = "open_float";
            desc = "Line diagnostics";
          };
          "]d" = {
            action = "goto_next";
            desc = "Next Diagnostic";
          };
          "[d" = {
            action = "goto_prev";
            desc = "Previous Diagnostic";
          };
        };
        lspBuf = {
          "gd" = {
            action = "definition";
            desc = "Goto Definition";
          };
          "gr" = {
            action = "references";
            desc = "Goto References";
          };
          "gD" = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          "gI" = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          "gT" = {
            action = "type_definition";
            desc = "Type Definition";
          };
          "K" = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>li" = {
            action = "incoming_calls";
            desc = "Incomming Calls";
          };
          "<leader>lo" = {
            action = "outgoing_calls";
            desc = "Outgoing Calls";
          };
          "<leader>la" = {
            action = "code_action";
            desc = "Code Action";
          };
          "<leader>lr" = {
            action = "rename";
            desc = "Rename";
          };
          "<leader>lw" = {
            action = "workspace_symbol";
            desc = "Workspace Symbol";
          };
          "<leader>lf" = {
            action = "format";
            desc = "Format";
          };
        };
      };
    };
    # JS/TS lsp
    typescript-tools.enable = true;
  };
}
