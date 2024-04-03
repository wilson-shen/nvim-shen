return {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")

      require("notify.config").setup({
        stages = 'slide',
      });

      local filtered_message = { "No information available" }

      -- Override notify function to filter out messages
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.notify = function(message, level, opts)
        local merged_opts = vim.tbl_extend("force", {
          on_open = function(win)
            local buf = vim.api.nvim_win_get_buf(win)
            vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
          end,
        }, opts or {})

        for _, msg in ipairs(filtered_message) do
          if message == msg then
            return
          end
        end
        return notify(message, level, merged_opts)
      end

      -- Update colors to use monokai colors
      vim.cmd([[
        highlight NotifyERRORBorder guifg=#ff6188
        highlight NotifyERRORIcon guifg=#ff6188
        highlight NotifyERRORTitle  guifg=#ff6188
        highlight NotifyINFOBorder guifg=#78dce8
        highlight NotifyINFOIcon guifg=#78dce8
        highlight NotifyINFOTitle guifg=#78dce8
        highlight NotifyWARNBorder guifg=#ffd866
        highlight NotifyWARNIcon guifg=#ffd866
        highlight NotifyWARNTitle guifg=#ffd866
      ]])
    end,
  },
}
