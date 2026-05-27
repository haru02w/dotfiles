{ den, ... }: {
  den.aspects.nixvim.homeManager.programs.nixvim = {
    globals.loaded_netrwPlugin = 1;
    plugins.yazi = {
      enable = true;
      settings.open_for_directories = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "-";
        action = "<cmd>Yazi<cr>";
        options.desc = "Open yazi file manager";
      }
    ];
  };
}
