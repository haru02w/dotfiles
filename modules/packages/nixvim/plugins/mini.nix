{
  perSystem.nixvim.module =
    let
      mkInline = s: { __raw = s; };
      tsSpec =
        a: i:
        mkInline ''
          require('mini.ai').gen_spec.treesitter({ a = '${a}', i = '${i}' })
        '';
      linear = mkInline "require('mini.animate').gen_timing.linear({ duration = 30, unit = 'total' })";
    in
    {
      plugins.mini = {
        enable = true;
        mockDevIcons = true;
        modules = {
          surround = { };

          ai.custom_textobjects = {
            "=" = tsSpec "@assignment.outer" "@assignment.inner";
            a = tsSpec "@parameter.outer" "@parameter.inner";
            i = tsSpec "@conditional.outer" "@conditional.inner";
            l = tsSpec "@loop.outer" "@loop.inner";
            f = tsSpec "@call.outer" "@call.inner";
            m = tsSpec "@function.outer" "@function.inner";
            c = tsSpec "@class.outer" "@class.inner";
            t = tsSpec "@comment.outer" "@comment.inner";
          };

          icons = { };
          cursorword = { };

          indentscope.draw.animation = mkInline "require('mini.indentscope').gen_animation.none()";

          trailspace = { };
          map = { };

          animate = {
            cursor.timing = linear;
            scroll.timing = linear;
            resize.timing = linear;
            open.timing = linear;
            close.timing = linear;
          };
        };
      };

      extraConfigLua = ''
        -- Jump half a page (up/down) and recenter as a single mini.animate scroll.
        -- Cursor animation is suppressed for the jump; only the zz scroll animates.
        function _G.HalfPageJump(dir)
          local h = math.floor(vim.api.nvim_win_get_height(0) / 2)
          local cur = vim.fn.line('.')
          local target = dir == 'down'
            and math.min(cur + h, vim.fn.line('$'))
            or math.max(cur - h, 1)
          local prev = vim.b.minianimate_disable
          vim.b.minianimate_disable = true
          vim.api.nvim_win_set_cursor(0, { target, 0 })
          vim.b.minianimate_disable = prev
          vim.cmd('normal! zz')
        end
      '';

      keymaps = [
        {
          mode = "n";
          key = "<leader>tmm";
          action.__raw = "function() MiniMap.toggle() end";
          options.desc = "Toggle minimap";
        }
        {
          mode = "n";
          key = "<C-d>";
          action.__raw = "function() _G.HalfPageJump('down') end";
          options.desc = "Half page down + recenter (single animation)";
        }
        {
          mode = "n";
          key = "<C-u>";
          action.__raw = "function() _G.HalfPageJump('up') end";
          options.desc = "Half page up + recenter (single animation)";
        }
      ];
    };
}
