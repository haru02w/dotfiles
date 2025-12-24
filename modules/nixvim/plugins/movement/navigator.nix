{
  plugins.tmux-navigator = {
    enable = true;
    settings = {
      no_mappings = 1;
      disable_when_zoomed = 1;
    };
    keymaps = [
      {
        action = "left";
        key = "<C-Space>h";
      }
      {
        action = "down";
        key = "<C-Space>j";
      }
      {
        action = "up";
        key = "<C-Space>k";
      }
      {
        action = "right";
        key = "<C-Space>l";
      }
      {
        action = "previous";
        key = "<C-Space>p";
      }
    ];
  };
}
