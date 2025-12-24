{lib, ...}:
# WARNING: this only works because sops creates '.config/openrouter-api.key' file
# in the host config. Create it to use standalone
with lib.nixvim; {
  plugins.codecompanion = {
    enable = true;
    settings = {
      adapters = {
        http.openrouter = mkRaw ''
          function()
            return require("codecompanion.adapters").extend("openai_compatible",{
              env = {
                url = "https://openrouter.ai/api",
                api_key = os.getenv('OPENROUTER_API_KEY'),
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "anthropic/claude-sonnet-4.5",
                },
              },
            })
          end
        '';
      };
      strategies = {
        agent = {
          adapter = "openrouter";
        };
        chat = {
          adapter = "openrouter";
        };
        inline = {
          adapter = "openrouter";
        };
      };
    };
  };
}
