{ lib, config, pkgs, ... }:
with lib;
let cfg = config.modules.presets.desktop-v1.tmux;
in {
  options.modules.presets.desktop-v1.tmux.enable =
    mkEnableOption "desktop-v1 tmux";

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      mouse = true;
      prefix = "C-Space";
      keyMode = "vi";
      clock24 = true;
      terminal = "screen-256color";
      baseIndex = true;
      newSession = true;
      escapeTime = 0;
      secureSocket = true;
      sensibleOnTop = true;
      customPaneNavigationAndResize = true;
      plugins = with pkgs; [
        tmuxPlugins.cpu
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '60' # minutes
          '';
        }
      ];
    };
  };
}
