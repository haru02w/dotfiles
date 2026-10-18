{
  perSystem.nixvim.module.plugins.indent-o-matic = {
    enable = true;
    lazyLoad.settings.event = [
      "BufReadPost"
      "BufNewFile"
    ];
  };
}
