vim.keymap.set("", "<Esc>", "<ESC>:noh<CR>:lua require('notify').dismiss()<CR>", { silent = true })

local colors = {
  fujiGray = "#727169",
  roninYellow = "#FF9E3B",
  samuraiRed = "#E82424",
  springGreen = "#98BB6C",
  sumiInk1 = "#1F1F28",
}

return {
  priority = 100,
  "rcarriga/nvim-notify",
  opts = {
    background_colour = colors.sumiInk1,
  },
  config = function()
    vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = colors.samuraiRed })
    vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = colors.samuraiRed })
    vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = colors.samuraiRed })
    vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = colors.roninYellow })
    vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = colors.roninYellow })
    vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = colors.roninYellow })
    vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = colors.springGreen })
    vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = colors.springGreen })
    vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = colors.springGreen })
    vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = colors.fujiGray })
    vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = colors.fujiGray })
    vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = colors.fujiGray })
    vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = colors.fujiGray })
    vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = colors.fujiGray })
    vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = colors.fujiGray })

    local notify = require("notify")

    vim.notify = function(msg, level, opts)
      if msg and type(msg) == "string" then
        if string.find(msg, "is not attached to client") then
          return
        end
        if msg == "No information available" then
          return
        end
      end
      notify(msg, level, opts)
    end

    notify.setup({
      fps = 60,
      timeout = 2000,
      top_down = true,
      stages = "fade_in_slide_out",
      render = "minimal",
      background_colour = "#000000",
    })
  end,
}
