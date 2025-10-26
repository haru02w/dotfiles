{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.bash = {
    bashrcExtra = ''
      # The next line updates PATH for the Google Cloud SDK.
      if [ -f '/home/joaomillane/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/home/joaomillane/Downloads/google-cloud-sdk/path.bash.inc'; fi

      # The next line enables shell command completion for gcloud.
      if [ -f '/home/joaomillane/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/home/joaomillane/Downloads/google-cloud-sdk/completion.bash.inc'; fi
    '';
    initExtra = ''
      zsh
    '';
  };
}
