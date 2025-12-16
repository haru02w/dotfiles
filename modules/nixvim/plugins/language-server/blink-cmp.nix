{pkgs, ...}: {
  plugins.blink-cmp = {
    # TODO: setup cmdline settings and ai sources
    enable = true;
    settings = {
      signature = {
        enabled = true;
        keymap = {
          "<C-b>" = ["scroll_signature_up" "fallback"];
          "<C-f>" = ["scroll_signature_down" "fallback"];
        };
      };
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
          show_on_accept_on_trigger_character = true;
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
          snippets.score_offset = 6;
          lsp.score_offset = 5;
          path.score_offset = 4;
          emoji = {
            module = "blink-emoji";
            score_offset = 3;
          };
          ripgrep = {
            module = "blink-ripgrep";
            async = true;
            score_offset = 2;
          };
          dictionary = {
            module = "blink-cmp-dictionary";
            async = true;
            score_offset = 1;
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
