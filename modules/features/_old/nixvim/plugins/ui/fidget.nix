{ den, ... }: {
  den.aspects.nixvim.homeManager.programs.nixvim = {
    plugins.fidget = {
      enable = true;
      settings.notification.window.winblend = 0;
    };
  };
}
