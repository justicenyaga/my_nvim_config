return {
  {
    "iamcco/markdown-preview.nvim",
    event = "BufRead",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>mdp", ":MarkdownPreview<CR>", opts) -- Start the preview
      vim.keymap.set("n", "<leader>mdx", ":MarkdownPreviewStop<CR>", opts) -- Stop the preview
    end,
  },
}
