{lib, ...}:
with lib.nixvim; {
  plugins.minuet = {
    enable = true;
    settings = {
      provider = "openai_compatible";
      provider_options = {
        openai_compatible = {
          api_key = mkRaw "os.getenv('OPENROUTER_API_KEY')";
          end_point = "https://openrouter.ai/api/v1/chat/completions";
          model = "mistralai/devstral-small-2505";
          name = "OpenRouter";
          stream = true;
          optional = {
            max_tokens = 256;
            provider.sort = "throughput";
          };
        };
      };
    };
  };
}
