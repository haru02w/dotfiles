{
  den.aspects.zsh = {
    nixos.programs.zsh = {
      enable = true;
      # home-manager runs its own compinit in ~/.zshrc; avoid the redundant
      # global one in /etc/zshrc (saves a full compinit, ~waiting per shell).
      enableGlobalCompInit = false;
    };
    homeManager =
      { pkgs, ... }:
      {
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
          fzf.enable = true;
          zsh = {
            enable = true;
            autocd = true;
            defaultKeymap = "emacs";
            enableCompletion = true;
            syntaxHighlighting.enable = true;
            autosuggestion.enable = true;
            historySubstringSearch = {
              enable = true;
              searchUpKey = [ "^[[A" ];
              searchDownKey = [ "^[[B" ];
            };
            history = {
              expireDuplicatesFirst = true;
              ignoreSpace = false;
              share = true;
              save = 15000;
            };

            shellAliases = {
              #tm = "tmux new -c $(find * -type d | fzf)";
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
