{ den, ... }:
{
  den.aspects.nixvim.homeManager.programs.nixvim = {
    plugins.nvim-autopairs = {
      enable = true;
      settings = {
        check_ts = true;
        disable_filetype = [ "TelescopePrompt" ];
      };
    };
  };
}
