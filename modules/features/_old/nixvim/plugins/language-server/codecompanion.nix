{ den, ... }: {
  den.aspects.nixvim.homeManager = { lib, pkgs, ... }: with lib.nixvim; {
    programs.nixvim = {
      plugins.codecompanion = {
        enable = true;
        settings = {
          chat = {
            fold_reasoning = true;
            show_reasoning = true;
            window = {
              buflisted = false;
              width = 0.3;
              opts = {
                breakindent = true;
                linebreak = true;
                wrap = true;
              };
            };
            variables.buffer.opts.default_params = "all";
          };
          strategies = {
            agent.adapter = "opencode";
            chat.adapter = "opencode";
            inline.adapter = "opencode";
          };
        };
      };
      extraPackages = with pkgs; [ opencode ];
    };
  };
}
