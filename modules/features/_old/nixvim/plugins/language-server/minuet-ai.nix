{ den, ... }:
{
  den.aspects.nixvim.homeManager =
    { lib, ... }:
    with lib.nixvim;
    {
      programs.nixvim = {
        plugins.minuet = {
          enable = true;
          settings = {
            context_window = 4096;
            context_ratio = 0.9;
            throttle = 300;
            debounce = 200;
            request_timeout = 10;
            n_completions = 1;

            add_single_line_entry = true;
            after_cursor_filter_length = 50;
            before_cursor_filter_length = 5;

            provider = mkRaw ''
              (function()
                vim.fn.system('curl -s -m 0.1 http://localhost:11434/')
                if vim.v.shell_error == 0 then
                  return "openai_fim_compatible"
                else
                  return "openai_compatible"
                end
              end)()
            ''; # or "openai_fim_compatible"
            provider_options = {
              openai_fim_compatible = {
                api_key = "TERM";
                end_point = "http://localhost:11434/v1/completions";
                model = "qwen2.5-coder:1.5b";
                name = "Ollama";
                stream = true;
                optional = {
                  max_tokens = 200;
                  top_p = 0.95;
                  temperature = 0.1;
                  provider.sort = "throughput";
                };
              };
              openai_compatible = {
                api_key = "OPENROUTER_API_KEY";
                end_point = "https://openrouter.ai/api/v1/chat/completions";
                model = "qwen/qwen2.5-coder-7b-instruct";
                name = "OpenRouter";
                stream = true;
                optional = {
                  max_tokens = 200;
                  top_p = 0.95;
                  temperature = 0.1;
                  provider.sort = "throughput";
                };
              };
            };
          };
        };
      };
    };
}
