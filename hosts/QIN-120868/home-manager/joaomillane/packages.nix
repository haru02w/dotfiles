{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.bash = {
    bashrcExtra = ''
      # The next line updates PATH for the Google Cloud SDK.
      if [ -f "$HOME/.local/share/google-cloud-sdk/path.bash.inc" ]; then source "$HOME/.local/share/google-cloud-sdk/path.bash.inc"; fi

      # The next line enables shell command completion for gcloud.
      if [ -f "$HOME/.local/share/google-cloud-sdk/completion.bash.inc" ]; then source "$HOME/.local/share/google-cloud-sdk/completion.bash.inc"; fi

      export PATH="$HOME/.local/bin:$PATH"
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    '';
    initExtra = ''
      zsh
    '';
  };

  # rqi tab completion; 550 = before compinit
  programs.zsh.initContent = lib.mkOrder 550 ''
    fpath+=(~/Projects/rqi/completions)
  '';
}
