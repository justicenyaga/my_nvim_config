return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        go = { "goimports", "gofumpt" },
        lua = { "stylua" },
        python = { "isort", "black" },
      },
      formatters = {
        prettier = {
          args = function(self, ctx)
            if vim.endswith(ctx.filename, ".ejs") then
              return { "--stdin-filepath", "$FILENAME", "--parser", "html" }
            end
            return { "--stdin-filepath", "$FILENAME" }
          end,
          range_args = function(self, ctx, range)
            if vim.endswith(ctx.filename, ".ejs") then
              return { "--stdin-filepath", "$FILENAME", "--parser", "html", "--range", range }
            end
            return { "--stdin-filepath", "$FILENAME", "--range", range }
          end,
        },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
