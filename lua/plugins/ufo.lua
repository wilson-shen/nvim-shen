--- @diagnostic disable: unused-local, missing-fields
return {
  {
    "kevinhwang91/nvim-ufo",
    event = "BufEnter",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      local ufo = require("ufo")

      local fold_text = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      ufo.setup({
        close_fold_kinds_for_ft = {
          default = {
            "imports",
          },
        },
        provider_selector = function(_bufnr, _filetype, _buftype)
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = fold_text,
      })

      bind("n", "zR", ufo.openAllFolds, "Fold: Open All")
      bind("n", "zM", ufo.closeAllFolds, "Fold: Close All")

      -- Toggle folds according to level
      bind("n", "zm1", function()
        ufo.closeFoldsWith(0)
      end, "Fold: Close Level 1")
      bind("n", "zm2", function()
        ufo.closeFoldsWith(1)
      end, "Fold: Close Level 2")
      bind("n", "zm3", function()
        ufo.closeFoldsWith(2)
      end, "Fold: Close Level 3")
      bind("n", "zm4", function()
        ufo.closeFoldsWith(3)
      end, "Fold: Close Level 4")
      bind("n", "zm5", function()
        ufo.closeFoldsWith(4)
      end, "Fold: Close Level 5")
      bind("n", "zm6", function()
        ufo.closeFoldsWith(5)
      end, "Fold: Close Level 6")
      bind("n", "zm7", function()
        ufo.closeFoldsWith(6)
      end, "Fold: Close Level 7")
      bind("n", "zm8", function()
        ufo.closeFoldsWith(7)
      end, "Fold: Close Level 8")
      bind("n", "zm9", function()
        ufo.closeFoldsWith(8)
      end, "Fold: Close Level 9")

      bind("n", "K", function()
        local winid = ufo.peekFoldedLinesUnderCursor()

        if not winid then
          vim.lsp.buf.hover()
        end
      end)

      -- local lsp_capabilities = vim.tbl_deep_extend(
      --   'force',
      --   require('cmp_nvim_lsp').default_capabilities(),
      --   {
      --     textDocument = {
      --       foldingRange = {
      --         dynamicRegistration = false,
      --         lineFoldingOnly = true
      --       },
      --     },
      --   }
      -- )

      -- require('lsp-zero').extend_lspconfig({
      --   capabilities = lsp_capabilities,
      -- })
    end,
  },
}
