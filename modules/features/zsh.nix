{
  den.aspects.zsh = {
    nixos.programs.zsh.enable = true;
    homeManager = {
      pkgs,
      lib,
      ...
    }: {
      programs = {
        eza.enable = true;
        zoxide.enable = true;
        bat = {
          enable = true;
          extraPackages = with pkgs.bat-extras; [
            batdiff
            batman
            batgrep
            batwatch
          ];
        };
        zsh = {
          enable = true;
          autocd = true;
          defaultKeymap = "emacs";
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
              src = ./.;
              file = "p10k.zsh";
            }
          ];

          initContent = lib.mkBefore ''
            P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
            [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
          '';

          history = {
            expireDuplicatesFirst = true;
            ignoreSpace = false;
            share = true;
            save = 15000;
          };

          shellAliases = {
            tm = "tmux new -c $(find * -type d | fzf)";
            cdf = "cd $(find * -type d | fzf)";
            cat = "bat";
            man = "batman";
            rg = "batgrep";
            watch = "batwatch";
            gs = "git status";
            ga = "git add -A";
            gc = "git commit";
            gp = "git push";
          };
        };
      };
    };
  };
}
