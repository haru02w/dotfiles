{pkgs, ...}:
{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    autocd = true;

    #plugins
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "^[[A" "^K" ];
      searchDownKey = [ "^[[B" "^J"];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./dotconfig;
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
    ''; */
    
    history = {
      expireDuplicatesFirst = true;
      ignoreSpace = false;
      share = true;
      save = 15000;
    };

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/.dotfiles";
    };
  };
}
