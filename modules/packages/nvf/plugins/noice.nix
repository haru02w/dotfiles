{
  perSystem.nvf.module.config.vim.ui.noice = {
    enable = true;
    setupOpts = {
      views.cmdline.position = {
        row = -1;
        col = 0;
      };
      cmdline = {
        view = "cmdline";
        format = {
          cmdline = false;
          search_down = false;
          search_up = false;
          filter = false;
          lua = false;
          help = false;
          input = false;
        };
      };
    };
  };
}
