{ den, ... }: {
  den.aspects.nixvim.homeManager = { lib, ... }: with lib.nixvim; {
    programs.nixvim = {
      plugins.treesitter-textobjects = {
        enable = true;
        settings = {
          select = {
            enable = false; # WARNING: false
            lookahead = true;
            keymaps = {
              "a=" = "@assignment.outer";
              "i=" = "@assignment.inner";
              "l=" = "@assignment.lhs";
              "r=" = "@assignment.rhs";

              "aa" = "@parameter.outer";
              "ia" = "@parameter.inner";

              "ai" = "@conditional.outer";
              "ii" = "@conditional.inner";

              "al" = "@loop.outer";
              "il" = "@loop.inner";

              "af" = "@call.outer";
              "if" = "@call.inner";

              "am" = "@function.outer";
              "im" = "@function.inner";

              "ac" = "@class.outer";
              "ic" = "@class.inner";

              "at" = "@comment.outer";
              "it" = "@comment.inner";
            };
          };
          move = {
            enable = true;
            goto_next_start = {
              "]a" = "@parameter.inner";
              "]f" = "@call.outer";
              "]m" = "@function.outer";
              "]c" = "@class.outer";
              "]i" = "@conditional.outer";
              "]l" = "@loop.outer";
            };
            goto_next_end = {
              "]A" = "@parameter.inner";
              "]F" = "@call.outer";
              "]M" = "@function.outer";
              "]C" = "@class.outer";
              "]I" = "@conditional.outer";
              "]L" = "@loop.outer";
            };
            goto_previous_start = {
              "[a" = "@parameter.inner";
              "[f" = "@call.outer";
              "[m" = "@function.outer";
              "[c" = "@class.outer";
              "[i" = "@conditional.outer";
              "[l" = "@loop.outer";
            };
            goto_previous_end = {
              "[A" = "@parameter.inner";
              "[F" = "@call.outer";
              "[M" = "@function.outer";
              "[C" = "@class.outer";
              "[I" = "@conditional.outer";
              "[L" = "@loop.outer";
            };
          };
          swap = {
            enable = true;
            swap_next = {
              "<leader>]a" = "@parameter.inner";
              "<leader>]m" = "@function.outer";
            };
            swap_previous = {
              "<leader>[a" = "@parameter.inner";
              "<leader>[m" = "@function.outer";
            };
          };
        };
      };
    };
  };
}
