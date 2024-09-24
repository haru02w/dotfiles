{
  plugins.nvim-autopairs = {
    enable = true;
    settings = {
      disable_filetype = [ "TelescopePrompt" ];
      check_ts = true;
    };
  };
  extraConfigLua = ''
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  '';
}
