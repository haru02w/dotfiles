{
  perSystem =
    { pkgs, ... }:
    {
      nvf.module.config.vim = {
        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
          setupOpts = {
            keymap.preset = "enter";
            completion.list.selection.preselect = false;
            sources = {
              default = [
                "snippets"
                "lsp"
                "path"
                "buffer"
                "ripgrep"
                "emoji"
                "dictionary"
              ];
              providers = {
                snippets.score_offset = 6;
                lsp.score_offset = 5;
                path.score_offset = 4;
                emoji.score_offset = 3;
                ripgrep = {
                  async = true;
                  score_offset = 2;
                };
                dictionary = {
                  async = true;
                  score_offset = 1;
                };
              };
            };
          };
          sourcePlugins = {
            emoji.enable = true;
            ripgrep.enable = true;
            dictionary = {
              enable = true;
              package = pkgs.vimPlugins.blink-cmp-dictionary;
              module = "blink-cmp-dictionary";
            };
          };
        };
        snippets.luasnip.enable = true;

        extraPackages = with pkgs; [
          ripgrep
          wordnet
        ];
      };
    };
}
