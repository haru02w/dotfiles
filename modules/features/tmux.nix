{
  den.aspects.tmux.homeManager =
    { config, pkgs, ... }:
    {
      home.packages = [ pkgs.tmux-sessionizer ];
      xdg.configFile."tms/config.toml".text = ''
        [[search_dirs]]
        path = "${config.home.homeDirectory}/Projects"
        depth = 10
      '';
      programs.tmux = {
        enable = true;
        mouse = true;
        prefix = "C-Space";
        keyMode = "vi";
        clock24 = true;
        terminal = "tmux-256color";
        baseIndex = 1;
        newSession = true;
        escapeTime = 0;
        secureSocket = true;
        sensibleOnTop = true;
        customPaneNavigationAndResize = true;
        historyLimit = 100000;
        plugins = with pkgs; [
          {
            plugin = tmuxPlugins.pain-control;
            extraConfig = ''set-option -g @pane_resize "10"'';
          }
          {
            plugin = tmuxPlugins.yank;
            extraConfig = ''
              set -g @yank_action 'copy-pipe'
            '';
          }
          {
            plugin = tmuxPlugins.resurrect;
            extraConfig = ''
              set -g @resurrect-strategy-nvim "session"
              set -g @resurrect-capture-pane-contents 'on'
            '';
          }
          {
            plugin = tmuxPlugins.continuum;
            extraConfig = ''
              set -g @continuum-restore "on"
              set -g @continuum-save-interval "15" # minutes
            '';
          }
        ];
      };
    };
}
