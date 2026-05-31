{
  perSystem =
    { pkgs, ... }:
    {
      nvf.module.config.vim = {
        lazy.plugins."hex.nvim" = {
          package = pkgs.vimPlugins.hex-nvim;
          setupModule = "hex";
          setupOpts = { };
          cmd = [
            "HexDump"
            "HexAssemble"
            "HexToggle"
          ];
        };

        extraPackages = with pkgs; [ xxd ];
      };
    };
}
