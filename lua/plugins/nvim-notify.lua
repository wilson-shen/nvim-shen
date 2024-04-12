---@diagnostic disable: missing-fields

return {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")

      notify.setup({
        background_colour = "#000000",
        stages = "slide",
      })

      local filtered_message = {
        "No information available",
        "method textDocument/documentHighlight is not supported by any of the servers registered for the current buffer",
      }

      -- Override notify function to filter out messages
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.notify = function(message, level, opts)
        message = string.gsub(message, '^%s*(.-)%s*$', '%1')

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
        highlight NotifyBackground guifg=#000000
      ]])
    end,
  },
}
