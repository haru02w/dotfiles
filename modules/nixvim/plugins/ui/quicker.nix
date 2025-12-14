{lib, ...}:
with lib.nixvim; {
  plugins.quicker.enable = true;
  keymaps = [
    {
      mode = "n";
      key = "<leader>q";
      action = mkRaw ''        function()
              require("quicker").toggle()
            end'';
      options.desc = "Toggle quickfix list";
    }
  ];
}
