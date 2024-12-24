{lib, ...}:
with lib.nixvim; {
  plugins.treesitter-textobjects = {
    enable = true;
    select = {
      enable = true;
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
      gotoNextStart = {
        "]a" = "@parameter.inner";
        "]f" = "@call.outer";
        "]m" = "@function.outer";
        "]c" = "@class.outer";
        "]i" = "@conditional.outer";
        "]l" = "@loop.outer";
      };
      gotoNextEnd = {
        "]A" = "@parameter.inner";
        "]F" = "@call.outer";
        "]M" = "@function.outer";
        "]C" = "@class.outer";
        "]I" = "@conditional.outer";
        "]L" = "@loop.outer";
      };
      gotoPreviousStart = {
        "[a" = "@parameter.inner";
        "[f" = "@call.outer";
        "[m" = "@function.outer";
        "[c" = "@class.outer";
        "[i" = "@conditional.outer";
        "[l" = "@loop.outer";
      };
      gotoPreviousEnd = {
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
      swapNext = {
        "<leader>]a" = "@parameter.inner";
        "<leader>]m" = "@function.outer";
      };
      swapPrevious = {
        "<leader>[a" = "@parameter.inner";
        "<leader>[m" = "@function.outer";
      };
    };
  };

  extraConfigLua = ''
    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
  '';

  keymaps = [
    # Support for repeatable moves
    {
      mode = ["n" "x" "o"];
      key = ";";
      action = mkRaw "ts_repeat_move.repeat_last_move";
    }
    {
      mode = ["n" "x" "o"];
      key = ",";
      action = mkRaw "ts_repeat_move.repeat_last_move_opposite";
    }

    # Needed to remove conflicts with default behaviours
    {
      mode = ["n" "x" "o"];
      key = "f";
      action = mkRaw "ts_repeat_move.builtin_f_expr";
      options.expr = true;
    }
    {
      mode = ["n" "x" "o"];
      key = "F";
      action = mkRaw "ts_repeat_move.builtin_F_expr";
      options.expr = true;
    }
    {
      mode = ["n" "x" "o"];
      key = "t";
      action = mkRaw "ts_repeat_move.builtin_t_expr";
      options.expr = true;
    }
    {
      mode = ["n" "x" "o"];
      key = "T";
      action = mkRaw "ts_repeat_move.builtin_T_expr";
      options.expr = true;
    }
  ];
}
