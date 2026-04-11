{
  pkgs,
  lib,
  ...
}:
with lib.nixvim; {
  plugins.blink-cmp = {
    # TODO: setup cmdline settings
    enable = true;
    settings = {
      signature.enabled = true;
      completion = {
        keyword.range = "full";
        list = {
          #max_items = 10;
          selection = {
            preselect = false;
            auto_insert = false;
          };
        };
        trigger = {
          prefetch_on_insert = false;
          show_on_accept_on_trigger_character = true;
          show_on_backspace = true;
          show_on_backspace_in_keyword = true;
          show_on_insert = true;
        };
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 400;
        };
        ghost_text.enabled = true;
      };
      keymap = {
        preset = "enter";
        "<C-k>" = mkRaw "require('minuet').make_blink_map()";
      };
      snippets.preset = "luasnip";
      sources = {
        default = ["snippets" "lsp" "path" "buffer" "ripgrep" "emoji" "dictionary"];
        providers = {
          minuet = {
            module = "minuet.blink";
            async = true;
            timeout_ms = 3000;
            score_offset = 50;
          };
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
