{pkgs, ...}: {
  plugins.luasnip = {
    enable = true;
    settings = {
      enable_autosnippets = true;
      cut_selection_keys = "<Tab>";
      history = false;
      delete_check_events = "TextChanged";
      region_check_events = "CursorMoved";
    };
    fromLua = [
      {paths = ../../snippets;}
    ];
    fromVscode = [
      {
        lazyLoad = true;
        paths = "${pkgs.vimPlugins.friendly-snippets}";
      }
    ];
  };
}
