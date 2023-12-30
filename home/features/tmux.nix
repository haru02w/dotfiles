{pkgs, lib, config, ...}:

{
  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    mouse = true;
    terminal = "screen-256color";
    historyLimit = 10000;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    # newSession = true;
    baseIndex = 1;
    # hjkl panel navigation
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    prefix = "C-Space";
    extraConfig = builtins.readFile ./dotconfig/tmux.conf +
      (if (lib.elem pkgs.wl-clipboard config.home.packages) then
        "set -s copy-command '${pkgs.wl-clipboard}/bin/wl-copy --foreground --type text/plain'"
      else 
        "")
    ;
    plugins = with pkgs.tmuxPlugins;[
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
}
