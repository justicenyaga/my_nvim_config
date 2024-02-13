return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  config = function()
    -- import nvim-dap plugin
    local dap = require("dap")

    -- import nvim-dap-ui plugin
    local dapui = require("dapui")

    -- import nvim-notify plugin
    local notify = require("notify")

    local keymap = vim.keymap -- for conciseness

    dap.set_log_level("INFO") -- Helps when configuring DAP, see logs with :DapShowLog

    dap.configurations = {
      go = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
      },
      javascript = {
        {
          type = "node2",
          name = "Launch",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        },
        {
          type = "node2",
          name = "Attach",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        },
      },
    }

    dap.adapters.go = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
        args = { "dap", "-l", "127.0.0.1:${port}" },
      },
    }

    dap.adapters.node2 = {
      type = "executable",
      command = "node",
      args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
    }

    vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

    -- Start debuggin sessions
    keymap.set("n", "<leader>ds", function()
      dap.continue()
      dapui.toggle({})
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
    end)

    keymap.set("n", "<leader>dl", require("dap.ui.widgets").hover)
    keymap.set("n", "<leader>dc", dap.continue)
    keymap.set("n", "<leader>db", dap.toggle_breakpoint)
    keymap.set("n", "<leader>dn", dap.step_over)
    keymap.set("n", "<leader>di", dap.step_into)
    keymap.set("n", "<leader>do", dap.step_out)
    keymap.set("n", "<leader>dC", function()
      dap.clear_breakpoints()
      notify("Breakpoints cleared", "warn")
    end)

    -- Close debugger and clear breakpoints
    keymap.set("n", "<leader>de", function()
      dap.clear_breakpoints()
      dapui.toggle({})
      dap.terminate()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) --
      notify("Debugger session ended", "warn")
    end)

    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸" },
      mappings = {
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      expand_lines = vim.fn.has("nvim-0.7"),
      layouts = {
        {
          elements = {
            "scopes",
          },
          size = 0.3,
          position = "right",
        },
        {
          elements = {
            "repl",
            "breakpoints",
          },
          size = 0.3,
          position = "bottom",
        },
      },
      floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil,
      },
    })
  end,
}
