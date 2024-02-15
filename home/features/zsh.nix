{ pkgs, ... }: {
  home.packages = with pkgs; [
    bat # better cat
    ripgrep # find words within files
    fzf # fuzzy finder
    entr # rerun command when file change
  ];

  programs.eza = {
    enable = true;
    enableAliases = true;
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

  programs.zsh = {
    enable = true;
    autocd = true;

    localVariables = { ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=5"; };
    #plugins
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
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
       '';
    */

    history = {
      expireDuplicatesFirst = true;
      ignoreSpace = false;
      share = true;
      save = 15000;
    };

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/.dotfiles";
      mntnas = "sudo mkdir -p /mnt/nas && sudo mount.nfs proxmox:/ /mnt/nas";
      cat = "bat";
      cd = "z";
      gs = "git status";
    };
  };
}
