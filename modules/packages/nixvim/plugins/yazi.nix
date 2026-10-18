{
  perSystem =
    { pkgs, ... }:
    {
      nixvim.module = {
        plugins.yazi = {
          enable = true;
          settings.open_for_directories = true;
        };

        keymaps = [
          {
            mode = "n";
            key = "<leader>-";
            action = "<cmd>Yazi<CR>";
            options.desc = "Open yazi at the current file";
          }
          {
            mode = "n";
            key = "<leader>cw";
            action = "<cmd>Yazi cwd<CR>";
            options.desc = "Open yazi in the working directory";
          }
          {
            mode = "n";
            key = "<c-up>";
            action = "<cmd>Yazi toggle<CR>";
            options.desc = "Resume the last yazi session";
          }
        ];

        extraPackages = with pkgs; [
          yazi
        ];
      };
    };
}
