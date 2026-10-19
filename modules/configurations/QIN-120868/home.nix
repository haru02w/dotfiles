# Standalone home-manager on a non-NixOS host:
# `home-manager switch --flake .#joaomillane@QIN-120868`
{
  den.aspects."joaomillane@QIN-120868".homeManager =
    {
      config,
      pkgs,
      self',
      ...
    }:
    {
      targets.genericLinux.enable = true;

      nix.package = pkgs.nix;
      nix.settings.trusted-users = [ config.home.username ];

      # No llama-cpp server on this host.
      nixvim.package = self'.packages.nixvim.extend { blink-edit.enable = false; };

      # Login shell stays bash; hand off to zsh.
      programs.bash = {
        enable = true;
        bashrcExtra = ''
          # The next line updates PATH for the Google Cloud SDK.
          if [ -f "$HOME/Downloads/google-cloud-sdk/path.bash.inc" ]; then source "$HOME/Downloads/google-cloud-sdk/path.bash.inc"; fi

          # The next line enables shell command completion for gcloud.
          if [ -f "$HOME/Downloads/google-cloud-sdk/completion.bash.inc" ]; then source "$HOME/Downloads/google-cloud-sdk/completion.bash.inc"; fi

          PATH="$PATH:$HOME/.local/bin"
        '';
        initExtra = ''
          zsh
        '';
      };
    };
}
