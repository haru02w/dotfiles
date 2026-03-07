{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  tmux-toggle-scratch = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-toggle-scratch";
    rtpFilePath = "tmux-toggle-scratch.tmux";
    version = "unstable";
    src = inputs.tmux-toggle-scratch;
  };
in {
  home.packages = with pkgs; [
    # CLI
    nixvim # custom
    rclone
    lazygit
    progress
    libqalculate
    ncdu
    btop
    fastfetch
    tldr
    zip
    unzip
    devenv
    yazi

    # Fonts
    nerd-fonts.fira-code
  ];

  fonts.fontconfig.enable = true;

  # NixVim (Neovim) Set default editor
  home.sessionVariables.EDITOR = "nvim";

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

      ##### SPLIT
      bind \\ split-window -v
      bind | split-window -h

      # Start selection
      bind-key -T copy-mode-vi v send-keys -X begin-selection

      # Enter copy-mode
      unbind [
      unbind ]
      bind-key v copy-mode
      bind-key p paste-buffer

      # Prevents prefix hanging
      set -g repeat-time 500

      ##### COPY MODE (unchanged, optional)
      bind-key -T copy-mode-vi "M-h" select-pane -L
      bind-key -T copy-mode-vi "M-j" select-pane -D
      bind-key -T copy-mode-vi "M-k" select-pane -U
      bind-key -T copy-mode-vi "M-l" select-pane -R
      bind-key -T copy-mode-vi "M-\\" select-pane -l

      ##### PANE SELECTION  (<prefix> h j k l)
      bind-key h if-shell "$is_vim" "send-keys C-Space h" "select-pane -L"
      bind-key j if-shell "$is_vim" "send-keys C-Space j" "select-pane -D"
      bind-key k if-shell "$is_vim" "send-keys C-Space k" "select-pane -U"
      bind-key l if-shell "$is_vim" "send-keys C-Space l" "select-pane -R"

      ##### PANE RESIZE (<prefix> <C-h/j/k/l>)
      bind-key C-h if-shell "$is_vim" "send-keys C-Space C-h" "resize-pane -L 3"
      bind-key C-j if-shell "$is_vim" "send-keys C-Space C-j" "resize-pane -D 3"
      bind-key C-k if-shell "$is_vim" "send-keys C-Space C-k" "resize-pane -U 3"
      bind-key C-l if-shell "$is_vim" "send-keys C-Space C-l" "resize-pane -R 3"

      ##### PANE SWAP (<prefix> H J K L)
      bind-key H if-shell "$is_vim" "send-keys C-Space H" "swap-pane -L"
      bind-key J if-shell "$is_vim" "send-keys C-Space J" "swap-pane -D"
      bind-key K if-shell "$is_vim" "send-keys C-Space K" "swap-pane -U"
      bind-key L if-shell "$is_vim" "send-keys C-Space L" "swap-pane -R"

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

  # bash
  programs.bash = {
    enable = true;
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

    initContent = lib.mkBefore ''
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
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];
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

  programs.opencode = {
    enable = true;
    settings = {
      # Custom providers
    };
  };
}
