{
  perSystem =
    { pkgs, ... }:
    {
      nvf.module.config.vim = {
        utility.yazi-nvim = {
          enable = true;
          setupOpts.open_for_directories = true;
        };

        extraPackages = with pkgs; [
          yazi
        ];
      };
    };
}
