{
  # TODO: configure tmux too
  plugins.tmux-navigator = {
    enable = true;
    settings = {
      no_mappings = 1;
      disable_when_zoomed = 1;
    };
    keymaps = [
      {
        action = "left";
        key = "<C-w>h";
      }
      {
        action = "down";
        key = "<C-w>j";
      }
      {
        action = "up";
        key = "<C-w>k";
      }
      {
        action = "right";
        key = "<C-w>l";
      }
      {
        action = "previous";
        key = "<C-w>p";
      }
    ];
  };
}
