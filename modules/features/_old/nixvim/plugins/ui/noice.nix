{ den, ... }: {
  den.aspects.nixvim.homeManager.programs.nixvim = {
    plugins.noice = {
      enable = true;
      settings = {
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
        presets.long_message_to_split = true;
        routes = [
          {
            filter = {
              event = "notify";
              kind = "info";
            };
            opts.history = true;
          }
        ];
      };
    };
  };
}
