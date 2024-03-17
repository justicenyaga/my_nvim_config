return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      preview_config = {
        border = "rounded",
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        -- move to the next hunk
        map("n", "]h", function()
          if vim.wo.diff then
            return "]h"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- move to the previous hunk
        map("n", "[h", function()
          if vim.wo.diff then
            return "[h"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map("n", "<leader>gac", gs.stage_hunk) -- stage hunk
        map("n", "<leader>grc", gs.reset_hunk) -- reset hunk
        -- stage selected hunk
        map("v", "<leader>gac", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        -- reset selected hunk
        map("v", "<leader>grc", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("n", "<leader>guc", gs.undo_stage_hunk) -- undo stage hunk
        map("n", "<leader>gcp", gs.preview_hunk) -- preview hunk
        -- hunk blame
        map("n", "<leader>gbh", function()
          gs.blame_line({ full = true })
        end)
        map("n", "<leader>gbt", gs.toggle_current_line_blame) -- toggle blame on line under cursor
        map("n", "<leader>gD", gs.toggle_deleted) -- toggle deleted

        -- Text objects
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>") -- select hunk
      end,
    })
  end,
}
