return {
  "lukas-reineke/indent-blankline.nvim",
  dependencies = {
    "HiPhish/rainbow-delimiters.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  config = function()
    local set_hl = vim.api.nvim_set_hl -- for conciseness

    local highlight = {
      "RainbowYellow",
      "RainbowViolet",
      "RainbowBlue",
      "RainbowGreen",
      "RainbowCyan",
      -- "RainbowRed",
      -- "RainbowOrange",
    }

    local hooks = require("ibl.hooks")
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- everytime the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- set_hl(0, "RainbowRed", { fg = "#E06C75" })
      set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      -- set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      set_hl(0, "RainbowGreen", { fg = "#98C379" })
      set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    vim.g.rainbow_delimiters = { highlight = highlight }
    require("ibl").setup({ scope = { highlight = highlight } })

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
