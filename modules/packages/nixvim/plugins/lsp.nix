{
  perSystem.nixvim.module = {
    plugins.lspconfig.enable = true;

    # Prefer LSP folding over treesitter when the server supports it.
    autoCmd = [
      {
        event = "LspAttach";
        desc = "Use LSP foldexpr when supported";
        callback.__raw = ''
          function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if client and client:supports_method('textDocument/foldingRange') then
              vim.wo[vim.api.nvim_get_current_win()][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
            end
          end
        '';
      }
    ];

    lsp = {
      inlayHints.enable = true;

      # nvf's default lsp mappings (openDiagnosticFloat moved to <leader>ld)
      keymaps = [
        {
          key = "<leader>lgd";
          lspBufAction = "definition";
          options.desc = "Go to definition";
        }
        {
          key = "<leader>lgD";
          lspBufAction = "declaration";
          options.desc = "Go to declaration";
        }
        {
          key = "<leader>lgt";
          lspBufAction = "type_definition";
          options.desc = "Go to type";
        }
        {
          key = "<leader>lgi";
          lspBufAction = "implementation";
          options.desc = "List implementations";
        }
        {
          key = "<leader>lgr";
          lspBufAction = "references";
          options.desc = "List references";
        }
        {
          key = "<leader>lgn";
          action.__raw = "function() vim.diagnostic.jump({ count = 1, float = true }) end";
          options.desc = "Go to next diagnostic";
        }
        {
          key = "<leader>lgp";
          action.__raw = "function() vim.diagnostic.jump({ count = -1, float = true }) end";
          options.desc = "Go to previous diagnostic";
        }
        {
          key = "<leader>ld";
          action.__raw = "vim.diagnostic.open_float";
          options.desc = "Open diagnostic float";
        }
        {
          key = "<leader>lH";
          lspBufAction = "document_highlight";
          options.desc = "Document highlight";
        }
        {
          key = "<leader>lS";
          lspBufAction = "document_symbol";
          options.desc = "List document symbols";
        }
        {
          key = "<leader>lwa";
          lspBufAction = "add_workspace_folder";
          options.desc = "Add workspace folder";
        }
        {
          key = "<leader>lwr";
          lspBufAction = "remove_workspace_folder";
          options.desc = "Remove workspace folder";
        }
        {
          key = "<leader>lwl";
          action.__raw = "function() vim.print(vim.lsp.buf.list_workspace_folders()) end";
          options.desc = "List workspace folders";
        }
        {
          key = "<leader>lws";
          lspBufAction = "workspace_symbol";
          options.desc = "List workspace symbols";
        }
        {
          key = "<leader>lh";
          lspBufAction = "hover";
          options.desc = "Trigger hover";
        }
        {
          key = "<leader>ls";
          lspBufAction = "signature_help";
          options.desc = "Signature help";
        }
        {
          key = "<leader>ln";
          lspBufAction = "rename";
          options.desc = "Rename symbol";
        }
        {
          key = "<leader>la";
          lspBufAction = "code_action";
          options.desc = "Code action";
        }
        {
          key = "<leader>lf";
          action.__raw = "function() require('conform').format({ lsp_format = 'fallback' }) end";
          options.desc = "Format";
        }
        {
          key = "[d";
          action.__raw = "function() vim.diagnostic.jump({ count = -1, float = true }) end";
          options.desc = "Go to previous diagnostic";
        }
        {
          key = "]d";
          action.__raw = "function() vim.diagnostic.jump({ count = 1, float = true }) end";
          options.desc = "Go to next diagnostic";
        }
        {
          key = "gd";
          lspBufAction = "definition";
          options.desc = "Go to definition";
        }
        {
          key = "gO";
          lspBufAction = "document_symbol";
          options.desc = "Go to document symbols";
        }
        {
          key = "gr";
          lspBufAction = "references";
          options.desc = "List references";
        }
        {
          key = "gI";
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
          key = "gK";
          lspBufAction = "signature_help";
          options.desc = "Signature help";
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
          key = "<leader>lr";
          lspBufAction = "rename";
          options.desc = "Rename symbol";
        }
      ];
    };
  };
}
