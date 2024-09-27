{
  plugins = {
    codeium-nvim = {
      enable = true;
      settings.enable_chat = true;
    };
    cmp = {
      enable = true;
      autoEnableSources = true;
      filetype = {
        "gitcommit" = {
          sources = [ { name = "cmp_git"; } { name = "buffer"; } ];
        };
      };
      cmdline = let
        searchSources = {
          sources = [
            { name = "nvim_lsp_document_symbol"; }
            { name = "buffer"; }
            { name = "async_path"; }
          ];
          view.entries = {
            name = "wildmenu";
            separator = "|";
          };
        };
      in {
        "?" = searchSources;
        "/" = searchSources;
        ":" = {
          sources = [
            { name = "async_path"; }
            { name = "cmdline"; }
            { name = "cmdline_history"; }
          ];
        };
      };
      settings = {
        experimental.ghost_text = true;
        snippet.expand = "luasnip";
        performance = {
          fetching_timeout = 200;
          maxViewEntries = 30;
        };
        sources = [
          { name = "codeium"; }
          {
            name = "luasnip";
            option.show_autosnippets = true;
            keywordLength = 3;
          }
          {
            name = "nvim_lsp";
            keywordLength = 3;
          }
          { name = "nvim_lsp_signature_help"; }
          { name = "emoji"; }
          {
            name = "async_path";
            keywordLength = 3;
          }
          {
            name = "buffer";
            keywordLength = 3;
          }
          { name = "rg"; }
          { name = "nvim_lua"; }
          {
            name = "dictionary";
            keywordLength = 3;
          }
        ];
        mapping = {
          "<Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end, {'i','s','c'})
          '';
          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end, {'i','s','c'})
          '';
          "<C-n>" = ''
            cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if luasnip.locally_jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<C-p>" = ''
            cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<C-e>" = "cmp.mapping(cmp.mapping.abort(), {'i','s','c'})";
          "<C-b>" = "cmp.mapping(cmp.mapping.scroll_docs(-4), {'i','s','c'})";
          "<C-f>" = "cmp.mapping(cmp.mapping.scroll_docs(4), {'i','s','c'})";
          "<C-Space>" = "cmp.mapping(cmp.mapping.complete(), {'i','s','c'})";
          "<CR>" =
            "cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = false})";
          "<S-CR>" =
            "cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false})";
        };
      };
    };
  };
}
