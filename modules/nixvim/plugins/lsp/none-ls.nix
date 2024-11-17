{
  plugins.none-ls = {
    enable = true;
    settings.updateInInsert = false;
    sources = {
      code_actions = {
        statix.enable = true;
        refactoring.enable = true;
      };
      diagnostics = {
        # TODO:
        statix.enable = true;
        yamllint.enable = true;
      };
      hover = {
        dictionary.enable = true;
        printenv.enable = true;
      };
      formatting = {
        # nix
        alejandra.enable = true;
        # python
        blackd = {
          enable = true;
          settings.fast = true;
        };
        # C/C++
        clang_format.enable = true;
        # JS/TS
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
          settings.extra_args = ["--no-semi" "--single-quote"];
        };
        # lua
        stylua.enable = true;
        # yaml
        yamlfmt.enable = true;
      };
    };
  };
}
