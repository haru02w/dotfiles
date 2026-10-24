{ inputs, ... }:
{
  # Not packaged in nixpkgs yet.
  flake-file.inputs.blink-edit-nvim = {
    url = "github:haru02w/blink-edit.nvim";
    flake = false;
  };

  perSystem =
    { pkgs, ... }:
    {
      nixvim.module =
        { config, lib, ... }:
        {
          # Off by default; the llama-cpp aspect (Sweep server) enables it.
          options.blink-edit.enable = lib.mkEnableOption "blink-edit next-edit predictions";

          config = lib.mkIf config.blink-edit.enable {
            extraPlugins = [
              (pkgs.vimUtils.buildVimPlugin {
                name = "blink-edit.nvim";
                src = inputs.blink-edit-nvim;
              })
            ];

            # Next-edit predictions as ghost text, served by the llama-cpp aspect
            # (Sweep Next-Edit 1.5B). Insert mode: <Tab> accept hunk, <C-j> accept
            # line, <C-]> clear. :BlinkEditStatus checks the server.
            extraConfigLua = ''
              require("blink-edit").setup({
                llm = {
                  provider = "sweep",
                  backend = "openai",
                  url = "http://127.0.0.1:8080",
                  model = "sweep",
                },
                -- Its <Esc> reject clears the prediction but stays in insert mode;
                -- leave <Esc> alone (InsertLeave already clears predictions).
                keymaps = { insert = { reject = false } },
              })
            '';

            keymaps = [
              {
                mode = "n";
                key = "<leader>te";
                action = "<cmd>BlinkEditToggle<CR>";
                options.desc = "Toggle next-edit predictions";
              }
            ];
          };
        };
    };
}
