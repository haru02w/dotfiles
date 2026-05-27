{ den, ... }:
{
  flake-file.inputs.tmux-toggle-scratch = {
    url = "github:laktak/tmux-toggle-scratch";
    flake = false;
  };

  den.aspects.tmux.homeManager =
    {
      pkgs,
      inputs,
      ...
    }:
    let
      tmux-toggle-scratch = pkgs.tmuxPlugins.mkTmuxPlugin {
        pluginName = "tmux-toggle-scratch";
        rtpFilePath = "tmux-toggle-scratch.tmux";
        version = "unstable";
        src = inputs.tmux-toggle-scratch;
      };
    in
    {
      programs.tmux = {
        enable = true;
        mouse = true;
        prefix = "C-Space";
        keyMode = "vi";
        clock24 = true;
        terminal = "screen-256color";
        baseIndex = 1;
        newSession = true;
        escapeTime = 0;
        secureSocket = true;
        sensibleOnTop = true;
        customPaneNavigationAndResize = true;
        historyLimit = 10000;
        plugins = with pkgs; [
          tmuxPlugins.cpu
          {
            plugin = tmux-toggle-scratch;
            extraConfig = ''
              set -g @toggle-scratch-keys 'C-a'
              set -g @toggle-scratch-popup-options '-w80% -h80%'
            '';
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
              set -g @continuum-save-interval "15"
            '';
          }
        ];
        extraConfig = ''
          is_vim="${pkgs.procps}/bin/ps -o state= -o comm= -t '#{pane_tty}' \
            | ${pkgs.gnugrep}/bin/grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
          tmux="${pkgs.tmux}/bin/tmux"

          set-option -s exit-empty off
          set-window-option -g automatic-rename on
          set-option -g set-titles on
          setw -g monitor-activity on
          set -g focus-events on
          set-option -g automatic-rename on
          set-option -g automatic-rename-format "#{b:pane_current_path}"

          bind q kill-session
          bind m resize-pane -Z
          bind c kill-pane

          bind \\ split-window -v
          bind | split-window -h

          bind-key -T copy-mode-vi v send-keys -X begin-selection

          unbind [
          unbind ]
          bind-key v copy-mode
          bind-key p paste-buffer

          set -g repeat-time 500

          bind-key -T copy-mode-vi "M-h" select-pane -L
          bind-key -T copy-mode-vi "M-j" select-pane -D
          bind-key -T copy-mode-vi "M-k" select-pane -U
          bind-key -T copy-mode-vi "M-l" select-pane -R
          bind-key -T copy-mode-vi "M-\\" select-pane -l

          bind-key h if-shell "$is_vim" "send-keys C-Space h" "select-pane -L"
          bind-key j if-shell "$is_vim" "send-keys C-Space j" "select-pane -D"
          bind-key k if-shell "$is_vim" "send-keys C-Space k" "select-pane -U"
          bind-key l if-shell "$is_vim" "send-keys C-Space l" "select-pane -R"

          bind-key C-h if-shell "$is_vim" "send-keys C-Space C-h" "resize-pane -L 3"
          bind-key C-j if-shell "$is_vim" "send-keys C-Space C-j" "resize-pane -D 3"
          bind-key C-k if-shell "$is_vim" "send-keys C-Space C-k" "resize-pane -U 3"
          bind-key C-l if-shell "$is_vim" "send-keys C-Space C-l" "resize-pane -R 3"

          bind-key H if-shell "$is_vim" "send-keys C-Space H" "swap-pane -L"
          bind-key J if-shell "$is_vim" "send-keys C-Space J" "swap-pane -D"
          bind-key K if-shell "$is_vim" "send-keys C-Space K" "swap-pane -U"
          bind-key L if-shell "$is_vim" "send-keys C-Space L" "swap-pane -R"

          bind-key 1 if-shell "$tmux select-window -t :1" "" "new-window -t :1"
          bind-key 2 if-shell "$tmux select-window -t :2" "" "new-window -t :2"
          bind-key 3 if-shell "$tmux select-window -t :3" "" "new-window -t :3"
          bind-key 4 if-shell "$tmux select-window -t :4" "" "new-window -t :4"
          bind-key 5 if-shell "$tmux select-window -t :5" "" "new-window -t :5"
          bind-key 6 if-shell "$tmux select-window -t :6" "" "new-window -t :6"
          bind-key 7 if-shell "$tmux select-window -t :7" "" "new-window -t :7"
          bind-key 8 if-shell "$tmux select-window -t :8" "" "new-window -t :8"
          bind-key 9 if-shell "$tmux select-window -t :9" "" "new-window -t :9"
          bind-key 0 if-shell "$tmux select-window -t :10" "" "new-window -t :10"

          set -g status-style bg=default
          set -g status-left-length 90
          set -g status-right-length 90
          set -g status-justify absolute-centre
          set -g status-left "#[fg=green] ❐ #S #[default]"
          set -g status-right "#[fg=colour172,bright,bg=default] 󰅐 %H:%M #[default]"
          set -ag status-right "#[fg=white,bg=default]  %a %d #[default]"
        '';
      };
    };
}
