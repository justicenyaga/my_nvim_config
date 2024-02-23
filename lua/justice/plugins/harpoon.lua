return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- Import harpoon plugin.
    local harpoon = require("harpoon")

    local keymap = vim.keymap -- for conciseness.

    -- Required:
    harpoon:setup()

    -- Keymaps:
    -- Mark the current buffer.
    keymap.set("n", "<leader>a", function()
      harpoon:list():append()
    end)

    -- Toggle open/close of marked files.
    keymap.set("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    -- Go the next marked file in the list.
    keymap.set("n", "<C-u>", function()
      harpoon:list():next()
    end)

    -- Go the previous marked file in the list.
    keymap.set("n", "<C-p>", function()
      harpoon:list():prev()
    end)

    -- Open the first file in the list.
    keymap.set("n", "<leader>1", function()
      harpoon:list():select(1)
    end)

    -- Open the second file in the list.
    keymap.set("n", "<leader>2", function()
      harpoon:list():select(2)
    end)

    -- Open the third file in the list.
    keymap.set("n", "<leader>3", function()
      harpoon:list():select(3)
    end)

    -- Open the fourth file in the list.
    keymap.set("n", "<leader>4", function()
      harpoon:list():select(4)
    end)
  end,
}
