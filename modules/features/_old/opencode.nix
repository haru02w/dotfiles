{ den, ... }:
{
  den.aspects.opencode.homeManager = {
    programs.opencode = {
      enable = true;
      settings = { };
    };
    home.sessionVariablesExtra = ''
      if [ -r "$HOME/.config/openrouter-api.key" ]; then
        export OPENROUTER_API_KEY="$(< "$HOME/.config/openrouter-api.key")"
      fi
    '';
  };
}
