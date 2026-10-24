{
  perSystem = _: {
    nixvim.module = {
      # Publishes @nvim_file / @nvim_modified pane options for the tmux status bar.
      extraConfigLua = ''
        if vim.env.TMUX and vim.env.TMUX_PANE then
          local pane = vim.env.TMUX_PANE
          local last = {}

          local function set(opt, val)
            if last[opt] == val then return end
            last[opt] = val
            vim.system({ "tmux", "set-option", "-pt", pane, opt, val, ";", "refresh-client", "-S" })
          end

          local function update()
            if vim.bo.buftype == "" then
              set("@nvim_file", vim.fn.expand("%:t"))
            end
            local modified = #vim.fn.getbufinfo({ buflisted = 1, bufmodified = 1 }) > 0
            set("@nvim_modified", modified and "1" or "")
          end

          local group = vim.api.nvim_create_augroup("TmuxStatus", { clear = true })
          vim.api.nvim_create_autocmd(
            { "BufEnter", "BufFilePost", "BufModifiedSet", "BufWritePost", "BufDelete", "FocusGained", "VimResume" },
            { group = group, callback = vim.schedule_wrap(update) }
          )
          vim.api.nvim_create_autocmd("VimLeavePre", {
            group = group,
            callback = function()
              vim.system({ "tmux", "set-option", "-put", pane, "@nvim_file", ";", "set-option", "-put", pane, "@nvim_modified" }):wait()
            end,
          })
        end
      '';
    };
  };
}
