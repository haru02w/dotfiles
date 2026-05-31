{
  perSystem.nvf.module =
    { lib, ... }:
    let
      mkInline = lib.generators.mkLuaInline;
      tsSpec =
        a: i:
        mkInline ''
          require('mini.ai').gen_spec.treesitter({ a = '${a}', i = '${i}' })
        '';
    in
    {
      config.vim = {
        mini = {
          surround.enable = true;

          ai = {
            enable = true;
            setupOpts.custom_textobjects = {
              "=" = tsSpec "@assignment.outer" "@assignment.inner";
              a = tsSpec "@parameter.outer" "@parameter.inner";
              i = tsSpec "@conditional.outer" "@conditional.inner";
              l = tsSpec "@loop.outer" "@loop.inner";
              f = tsSpec "@call.outer" "@call.inner";
              m = tsSpec "@function.outer" "@function.inner";
              c = tsSpec "@class.outer" "@class.inner";
              t = tsSpec "@comment.outer" "@comment.inner";
            };
          };

          icons.enable = true;
          cursorword.enable = true;
          hipatterns.enable = true;

          indentscope = {
            enable = true;
            setupOpts.draw.animation = mkInline "require('mini.indentscope').gen_animation.none()";
          };

          trailspace.enable = true;
          map.enable = true;

          animate = {
            enable = true;
            setupOpts = {
              cursor.timing = mkInline "require('mini.animate').gen_timing.linear({ duration = 30, unit = 'total' })";
              scroll.timing = mkInline "require('mini.animate').gen_timing.linear({ duration = 30, unit = 'total' })";
              resize.timing = mkInline "require('mini.animate').gen_timing.linear({ duration = 30, unit = 'total' })";
              open.timing = mkInline "require('mini.animate').gen_timing.linear({ duration = 30, unit = 'total' })";
              close.timing = mkInline "require('mini.animate').gen_timing.linear({ duration = 30, unit = 'total' })";
            };
          };
        };

        pluginRC.mini-icons-mock = lib.nvim.dag.entryAfter [ "mini-icons" ] ''
          require('mini.icons').mock_nvim_web_devicons()
        '';

        luaConfigRC.half-page-jump = lib.nvim.dag.entryAnywhere ''
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
            action = "MiniMap.toggle";
            lua = true;
            desc = "Toggle minimap";
          }
          {
            mode = "n";
            key = "<C-d>";
            action = "function() _G.HalfPageJump('down') end";
            lua = true;
            desc = "Half page down + recenter (single animation)";
          }
          {
            mode = "n";
            key = "<C-u>";
            action = "function() _G.HalfPageJump('up') end";
            lua = true;
            desc = "Half page up + recenter (single animation)";
          }
        ];
      };
    };
}
