{ pkgs, ... }:
{
  # Tmux
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
    plugins = with pkgs; [
      tmuxPlugins.cpu
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
    extraConfig = ''
      is_vim="${pkgs.procps}/bin/ps -o state= -o comm= -t '#{pane_tty}' \
        | ${pkgs.gnugrep}/bin/grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      tmux="${pkgs.tmux}/bin/tmux"

      # OPTIONS

      # keep server running after first run
      set-option -s exit-empty off

      # Automatically set window title
      set-window-option -g automatic-rename on
      set-option -g set-titles on

      # Highlight active window
      setw -g monitor-activity on

      set -g focus-events on

      set-option -g automatic-rename on
      set-option -g automatic-rename-format "#{b:pane_current_path}"

      # KEYBINDS

      # Close session
      bind q kill-session

      # Maximize pane size
      bind m resize-pane -Z

      # Delete pane
      bind c kill-pane

      # Split panes
      bind \\ split-window -v
      bind | split-window -h

      # Start selection
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      # copy content
      bind-key -T copy-mode-vi y send-keys -X copy-selection

      # Enter copy-mode
      unbind [
      unbind ]
      bind-key v copy-mode
      bind-key p paste-buffer

      # select panes on copy mode
      bind-key -T copy-mode-vi "M-h" select-pane -L
      bind-key -T copy-mode-vi "M-j" select-pane -D
      bind-key -T copy-mode-vi "M-k" select-pane -U
      bind-key -T copy-mode-vi "M-l" select-pane -R
      bind-key -T copy-mode-vi "M-\\" select-pane -l

      # selecting panes
      bind-key -n M-h if-shell "$is_vim" "send-keys M-h"  "select-pane -L"
      bind-key -n M-j if-shell "$is_vim" "send-keys M-j"  "select-pane -D"
      bind-key -n M-k if-shell "$is_vim" "send-keys M-k"  "select-pane -U"
      bind-key -n M-l if-shell "$is_vim" "send-keys M-l"  "select-pane -R"

      # resizing panes
      bind-key -n C-M-h if-shell "$is_vim" "send-keys C-M-h" "resize-pane -L 3"
      bind-key -n C-M-j if-shell "$is_vim" "send-keys C-M-j" "resize-pane -D 3"
      bind-key -n C-M-k if-shell "$is_vim" "send-keys C-M-k" "resize-pane -U 3"
      bind-key -n C-M-l if-shell "$is_vim" "send-keys C-M-l" "resize-pane -R 3"

      # swaping panes
      bind-key -n M-H if-shell "$is_vim" "send-keys M-H" "swap-pane -D"
      bind-key -n M-J if-shell "$is_vim" "send-keys M-J" "swap-pane -D"
      bind-key -n M-K if-shell "$is_vim" "send-keys M-K" "swap-pane -U"
      bind-key -n M-L if-shell "$is_vim" "send-keys M-L" "swap-pane -U"

      #Auto windowing
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

      # THEME
      set -g status-style bg=default
      set -g status-left-length 90
      set -g status-right-length 90
      set -g status-justify absolute-centre
      set -g status-left "#[fg=green] ❐ #S #[default]"
      set -g status-right "#[fg=colour172,bright,bg=default] 󰅐 %H:%M #[default]"
      set -ag status-right "#[fg=white,bg=default]  %a %d #[default]"
    '';
  };

  # ZSH
  programs.zsh = {
    enable = true;
    autocd = true;
    defaultKeymap = "emacs";
    #plugins
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = ["^[[A"];
      searchDownKey = ["^[[B"];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./non-nix;
        file = "p10k.zsh";
      }
    ];

    initExtraBeforeCompInit = ''
      # p10k instant prompt
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';

    /*
    envExtra =''
      setopt no_global_rcs
    '';
    */

    history = {
      expireDuplicatesFirst = true;
      ignoreSpace = false;
      share = true;
      save = 15000;
    };

    shellAliases = {
      nixos-switch = "sudo nixos-rebuild switch --flake ~/.dotfiles";
      nixos-boot = "sudo nixos-rebuild boot --flake ~/.dotfiles";
      # `tmux` stuff
      tm = "tmux new -c $(find * -type d | fzf)";
      cdf = "cd $(find * -type d | fzf)";
      # `bat` stuff
      cat = "bat";
      man = "batman";
      rg = "batgrep";
      watch = "batwatch";
      # git stuff
      gs = "git status";
      ga = "git add -A";
      gc = "git commit";
      gp = "git push";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batwatch];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    # config.global.strict_env = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  home.sessionVariables.DIRENV_LOG_FORMAT = "";
}
