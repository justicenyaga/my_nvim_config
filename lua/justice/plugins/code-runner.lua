return {
  "CRAG666/code_runner.nvim",
  event = "BufRead",
  config = function()
    require("code_runner").setup({
      term = {
        position = "vert",
        size = 50,
      },
      filetype = {
        go = "go run",
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt",
        },
        python = "python3 -u",
        javascript = "node",
      },
    })

    vim.keymap.set("n", "<leader>ex", function()
      local bufname = vim.fn.bufname("%")
      if bufname:find("crunner_") then
        vim.cmd("RunClose")
      else
        vim.cmd("RunCode")
      end
    end, { desc = "Toggle Code Runner" })
  end,
}
