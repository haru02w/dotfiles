{
  perSystem =
    { pkgs, ... }:
    {
      nixvim.module = {
        plugins.hex = {
          enable = true;
          lazyLoad.settings.cmd = [
            "HexDump"
            "HexAssemble"
            "HexToggle"
          ];
        };

        extraPackages = with pkgs; [ xxd ];
      };
    };
}
