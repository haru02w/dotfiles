{
  perSystem =
    { pkgs, ... }:
    {
      nvf.module.config.vim.lazy.plugins."quicker.nvim" = {
        package = pkgs.vimPlugins.quicker-nvim;
        setupModule = "quicker";
        setupOpts = { };
        ft = [ "qf" ];
      };
    };
}
