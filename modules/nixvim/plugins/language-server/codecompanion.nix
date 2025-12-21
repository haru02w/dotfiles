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
                api_key = function()
                  local path = vim.fn.expand("~/.config/openrouter-api.key")
                  local f = io.open(path, "r")
                  if f then
                    local content = f:read("*all"):gsub("%s+", "")
                    f:close()
                    return content
                  end
                  vim.notify("OpenRouter API key file not found at " .. path, vim.log.levels.WARN)
                  return ""
                end,
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "xiaomi/mimo-v2-flash:free",
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
