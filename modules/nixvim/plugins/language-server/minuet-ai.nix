{lib, ...}:
with lib.nixvim; {
  plugins.minuet = {
    enable = true;
    settings = {
      # Small context
      context_window = 1024;
      context_ratio = 0.85;
      # Latency tuning
      throttle = 250;
      debounce = 120;
      request_timeout = 2;
      n_completions = 1;
      # idk
      add_single_line_entry = true;
      # filtering
      after_cursor_filter_length = 20;
      before_cursor_filter_length = 2;

      provider = "openai_compatible";
      provider_options = {
        openai_compatible = {
          api_key = mkRaw "os.getenv('OPENROUTER_API_KEY')";
          end_point = "https://openrouter.ai/api/v1/chat/completions";
          model = "mistralai/codestral-2508";
          name = "OpenRouter";
          stream = true;
          optional = {
            max_tokens = 56;
            top_p = 0.9;
            provider.sort = "throughput";
            stop = ["\n\n"];
          };
        };
      };
    };
  };
}
