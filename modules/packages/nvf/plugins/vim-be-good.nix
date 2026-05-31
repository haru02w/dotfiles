{
  perSystem =
    { pkgs, ... }:
    {
      nvf.module.config.vim.lazy.plugins.vim-be-good = {
        package = pkgs.vimPlugins.vim-be-good;
        cmd = [ "VimBeGood" ];
      };
    };
}
