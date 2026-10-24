{
  den.aspects.tmux.homeManager =
    { config, pkgs, ... }:
    let
      c = config.lib.stylix.colors.withHashtag;

      # Matched by process name; titleAgents also by pane title (agents over ssh).
      agents = "claude|opencode|pi|openhands|codex|aider|gemini|goose|crush|amp|cursor-agent";
      titleAgents = "claude|opencode|openhands|codex|aider|gemini|goose|crush";

      # Nix wraps binaries as `.foo-wrapped`; show them as `foo`.
      program = ''#{s/^\.(.+)-wrapped$/\1/:pane_current_command}'';

      gitBranch = pkgs.writeShellScript "tmux-git-branch" ''
        b=$(${pkgs.git}/bin/git -C "$1" branch --show-current 2>/dev/null) && [ -n "$b" ] && printf ' %s' "$b"
      '';
    in
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
        extraConfig = ''
          bind -T copy-mode-vi v send -X begin-selection
          bind -T copy-mode-vi C-v send -X rectangle-toggle

          set -g status-interval 5
          set -g status-left-length 20
          set -g status-left ' #{?client_prefix,#[fg=${c.base0A}]󰌌,#{?pane_in_mode,#[fg=${c.base0B}]󰆏,#[fg=${c.base0D}]󰘳}}#[default] ┃'

          # Agent state: bell → needs you; output in the last 10s → working; else idle.
          set -g @w-agent '#{?window_bell_flag,󰂞,#{?#{e|<:#{e|-:%s,#{window_activity}},10},󰔟,✓}}'
          set -g @w-prog '#{?#{==:#{pane_current_command},nvim},nvim#{?@nvim_file, #{@nvim_file},}#{?@nvim_modified, ●,},#{?#{m/ri:^\.?(${agents})(-wrapped)?$,#{pane_current_command}},${program} #{T:@w-agent},#{?#{m/ri:(${titleAgents}),#{pane_title}},#{s/.*(${titleAgents}).*/\1/i:pane_title} #{T:@w-agent},${program}}}}'
          set -g window-status-format '#[fg=${c.base04}] #I #{E:@w-prog} · #{b:pane_current_path}#{?window_zoomed_flag, 󰊓,} #[default]'
          set -g window-status-current-format '#[fg=${c.base06},bg=${c.base02},bold] #I #{E:@w-prog} · #{b:pane_current_path}#{?window_zoomed_flag, 󰊓,} #[default]'

          set -g status-format[0] '#[align=left range=left]#{T:status-left}#[norange default]#{W:#[range=window|#{window_index}]#{T:window-status-format}#[norange default]#{?loop_last_flag,,│},#[range=window|#{window_index}]#{T:window-status-current-format}#[norange default]#{?loop_last_flag,,│}}┃#[align=centre]#(${gitBranch} "#{pane_current_path}")#[align=right range=right]#{T:status-right}#[norange default]'
        '';
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
            # status-right must be set before continuum loads: it injects its
            # autosave into status-right, so setting it later disables autosave.
            extraConfig = ''
              set -g @continuum-restore "on"
              set -g @continuum-save-interval "15"
              set -g status-right-length 50
              set -g status-right '┃ 󱂬 #S '
            '';
          }
        ];
      };
    };
}
