{ pkgs, ... }: {

  programs.zsh = {
    enable = true;
    autocd = true;
    localVariables = { ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=5"; };
    #plugins
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "^[[A" ];
      searchDownKey = [ "^[[B" ];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ../non-nix;
        file = ".p10k.zsh";
      }
    ];

    initExtraBeforeCompInit = ''
      # p10k instant prompt
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';

    /* envExtra =''
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

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
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
