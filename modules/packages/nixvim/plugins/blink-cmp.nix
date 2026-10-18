{
  perSystem =
    { pkgs, ... }:
    {
      nixvim.module = {
        plugins = {
          blink-cmp = {
            enable = true;
            settings = {
              keymap.preset = "enter";
              completion = {
                list.selection.preselect = false;
                # Only open once a word is being typed; elsewhere blink-edit's
                # next-edit predictions take over (see blink-edit.nix).
                trigger.show_on_trigger_character = false;
              };
              sources = {
                default = [
                  "snippets"
                  "lsp"
                  "path"
                  "buffer"
                  "ripgrep"
                  "emoji"
                  "dictionary"
                  "avante"
                ];
                providers = {
                  snippets.score_offset = 6;
                  lsp.score_offset = 5;
                  path.score_offset = 4;
                  emoji = {
                    module = "blink-emoji";
                    name = "Emoji";
                    score_offset = 3;
                  };
                  ripgrep = {
                    module = "blink-ripgrep";
                    name = "Ripgrep";
                    async = true;
                    score_offset = 2;
                  };
                  dictionary = {
                    module = "blink-cmp-dictionary";
                    name = "Dict";
                    async = true;
                    score_offset = 1;
                  };
                  # Rank avante's @mention / /command / #shortcut items high
                  # inside the AvanteInput buffer (source self-guards by filetype).
                  avante = {
                    module = "blink-cmp-avante";
                    name = "Avante";
                    score_offset = 100;
                  };
                };
              };
            };
          };

          blink-emoji.enable = true;
          blink-ripgrep.enable = true;
          blink-cmp-dictionary.enable = true;
          # avante sidebar completions (@mentions, /commands, #shortcuts).
          # the source only activates when filetype == AvanteInput.
          blink-cmp-avante.enable = true;

          # loaded by blink's default snippet engine (built-in vim.snippet)
          friendly-snippets.enable = true;
        };

        extraPackages = with pkgs; [
          ripgrep
          wordnet
        ];
      };
    };
}
