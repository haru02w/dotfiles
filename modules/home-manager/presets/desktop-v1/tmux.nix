{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v1.tmux;
in {
  options.modules.presets.desktop-v1.tmux.enable =
    mkEnableOption "desktop-v1 tmux";

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      sensibleOnTop = false;
      mouse = true;
      terminal = "screen-256color";
      historyLimit = 10000;
      disableConfirmationPrompt = true;
      escapeTime = 0;
      baseIndex = 1;
      keyMode = "vi";
      prefix = "M-s";
      extraConfig =
        ''
          is_vim="${pkgs.procps}/bin/ps -o state= -o comm= -t '#{pane_tty}' \
              | ${pkgs.gnugrep}/bin/grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
          tmux="${pkgs.tmux}/bin/tmux"
        ''
        + (
          if (lib.elem pkgs.wl-clipboard config.home.packages)
          then ''
            set -s copy-command '${pkgs.wl-clipboard}/bin/wl-copy --foreground --type text/plain'
          ''
          else ""
        )
        + builtins.readFile ./non-nix/tmux.conf;
      plugins = with pkgs.tmuxPlugins; [
        {plugin = vim-tmux-navigator;}
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-capture-pane-contents 'on'
          '';
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on' # only when needed
            set -g @continuum-save-interval '15' # minutes
          '';
        }
      ];
    };
  };
}
