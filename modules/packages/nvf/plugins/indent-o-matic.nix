{
  perSystem =
    { pkgs, ... }:
    {
      nvf.module.config.vim.lazy.plugins.indent-o-matic = {
        package = pkgs.vimPlugins.indent-o-matic;
        setupModule = "indent-o-matic";
        setupOpts = { };
        event = [
          "BufReadPost"
          "BufNewFile"
        ];
      };
    };
}
