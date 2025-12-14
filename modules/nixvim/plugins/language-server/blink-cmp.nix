{pkgs, ...}: {
  plugins.blink-cmp = {
    # TODO: setup cmdline settings and ai sources
    enable = true;
    settings = {
      completion = {
        keyword.range = "full";
        list = {
          max_items = 10;
          selection = {
            preselect = false;
            auto_insert = false;
          };
        };
        trigger = {
          show_on_backspace = true;
          show_on_backspace_in_keyword = true;
          show_on_insert = true;
        };
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 500;
        };
        ghost_text.enabled = true;
      };
      keymap.preset = "enter";
      snippets.preset = "luasnip";
      sources = {
        default = ["snippets" "lsp" "path" "buffer" "ripgrep" "emoji" "dictionary"];
        providers = {
          # snippets (preset luasnip)
          # lsp (default)
          # path (default)
          emoji.module = "blink-emoji";
          ripgrep = {
            async = true;
            module = "blink-ripgrep";
          };
          dictionary = {
            async = true;
            module = "blink-cmp-dictionary";
          };
        };
      };
    };
  };
  # CMP Sources
  plugins = {
    # snippets
    luasnip = {
      enable = true;
      settings = {
        enable_autosnippets = true;
        cut_selection_keys = "<Tab>";
        history = false;
        delete_check_events = "TextChanged";
        region_check_events = "CursorMoved";
      };
      fromLua = [
        {
          lazyLoad = true;
          paths = ../../snippets;
        }
      ];
      fromVscode = [
        {
          lazyLoad = true;
          paths = "${pkgs.vimPlugins.friendly-snippets}";
        }
      ];
    };
    # emoji
    blink-emoji.enable = true;
    # ripgrep
    blink-ripgrep.enable = true;
    # dictionary
    blink-cmp-dictionary.enable = true;
  };
}
