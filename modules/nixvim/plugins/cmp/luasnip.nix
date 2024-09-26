{ pkgs, ... }: {
  plugins.luasnip = {
    enable = true;
    settings = {
      enable_autosnippets = true;
      store_selection_keys = "<C-l>";
      history = false;
      delete_check_events = "InsertEnter";
      region_check_events = "InsertLeave";
    };
    fromVscode = [{
      lazyLoad = true;
      paths = "${pkgs.vimPlugins.friendly-snippets}";
    }];
  };
}
