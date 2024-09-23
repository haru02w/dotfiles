{pkgs, ...}: {
  plugins.luasnip = {
    enable = true;
    settings = {
      enable_autosnippets = true;
    };
    fromVscode = [
      {
        lazyLoad = true;
        paths = "${pkgs.vimPlugins.friendly-snippets}";
      }
    ];
  };
}
