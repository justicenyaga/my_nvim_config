return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- Set the fill character for diff lines
    vim.opt.fillchars:append({ diff = "╱" })

    local actions = require("diffview.actions")
    local diffview = require("diffview")
    local cb = require("diffview.config").diffview_callback
    local notify = require("notify")
    local util = require("justice.functions.util") -- Import util functions

    -- For conciseness
    local api, cmd, fn, keymap = vim.api, vim.cmd, vim.fn, vim.keymap

    -- Toggle file history of this file
    keymap.set("n", "<leader>gfh", function()
      local isDiff = fn.getwinvar(nil, "&diff")
      local bufName = api.nvim_buf_get_name(0)
      diffview.FOCUSED_HISTORY_FILE = bufName
      if isDiff ~= 0 or util.string_starts(bufName, "diff") then
        -- Close diffview if it's already open
        diffview.FOCUSED_HISTORY_FILE = nil
        cmd.bd()
        cmd.tabprev()
      else
        -- Open file history
        api.nvim_feedkeys(":DiffviewFileHistory " .. fn.expand("%"), "n", false)
        util.press_enter()
      end
    end)

    -- Toggle file history of the repo
    keymap.set("n", "<leader>gh", function()
      local isDiff = fn.getwinvar(nil, "&diff")
      local bufName = api.nvim_buf_get_name(0)
      if isDiff ~= 0 or util.string_starts(bufName, "diff") then
        -- Close diffview if it's already open
        cmd.bd()
        cmd.tabprev()
      else
        -- Open file history
        cmd.DiffviewFileHistory()
        util.press_enter()
      end
    end)

    -- Toggle viewing all current changes
    keymap.set("n", "<leader>gc", function()
      local isDiff = fn.getwinvar(nil, "&diff")
      local bufName = api.nvim_buf_get_name(0)
      if isDiff ~= 0 or util.string_starts(bufName, "diff") then
        -- Close diffview if it's already open
        cmd.bd()
        cmd.tabprev()
      else
        -- Open diffview with all current changes
        cmd.DiffviewOpen()
        util.press_enter()
      end
    end)
    --
    -- Review changes against main branch and the current HEAD (will break if no main branch present)
    keymap.set("n", "<leader>gr", function()
      local isDiff = fn.getwinvar(nil, "&diff")
      local bufName = api.nvim_buf_get_name(0)

      -- Get the current branch name
      local currentBranch = util.get_branch_name()

      -- If main is currently checked out, return with a warning
      if currentBranch == "main" then
        notify("HEAD is on main", "info")
        return
      else
        -- Check if there is a branch called "main"
        -- If not, return with an error
        if not util.branch_exists("main") then
          notify("No main branch, cannot review!", "error")
          return
        end
      end
      if isDiff ~= 0 or util.string_starts(bufName, "diff") then
        -- Close diffview if it's already open
        cmd.tabclose()
        cmd.tabprev()
      else
        -- Open diffview against main branch
        cmd.DiffviewOpen("main")
        util.press_enter()
      end
    end)

    -- Toggle diffview without any action
    keymap.set("n", "<leader>go", function()
      local isDiff = fn.getwinvar(nil, "&diff")
      local bufName = api.nvim_buf_get_name(0)
      if isDiff ~= 0 or util.string_starts(bufName, "diff") then
        -- Close diffview if it's already open
        cmd.tabclose()
        cmd.tabprev()
      else
        -- Open diffview without any specific action
        cmd.DiffviewOpen()
      end
    end)

    diffview.setup({
      view = {
        default = {
          winbar_info = false,
        },
        file_history = {
          winbar_info = false,
        },
      },
      diff_binaries = false,
      use_icons = true, -- Requires nvim-web-devicons
      icons = {
        folder_closed = "",
        folder_open = "",
      },
      signs = { fold_closed = "", fold_open = "" },
      file_panel = {
        listing_style = "tree", -- One of 'list' or 'tree'
        tree_options = {
          -- Only applies when listing_style is 'tree'
          flatten_dirs = true, -- Flatten dirs that only contain one single dir
          folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
        },
      },
      enhanced_diff_hl = true, -- See |diffview-config-enhanced_diff_hl|
      default_args = {
        -- Default args prepended to the arg-list for the listed commands
        DiffviewOpen = {},
        DiffviewFileHistory = {
          -- Follow only the first parent upon seeing a merge commit.
          first_parent = true,
          -- Include all refs.
          all = true,
          -- List only merge commits.
          merges = false,
          -- List commits in reverse order.
          reverse = false,
        },
      },
      hooks = {}, -- See ':h diffview-config-hooks'
      key_bindings = {
        disable_defaults = true, -- Disable the default key bindings
        -- The `view` bindings are active in the diff buffers, only when the current
        -- tabpage is a Diffview.
        view = {
          ["<C-n>"] = cb("select_next_entry"), -- Open the diff for the next file
          ["<C-p>"] = cb("select_prev_entry"), -- Open the diff for the previous file
          ["<CR>"] = cb("goto_file_edit"), -- Open the file in a new split in previous tabpage
          ["<C-w><C-f>"] = cb("goto_file_split"), -- Open the file in a new split
          ["<C-w>gf"] = cb("goto_file_tab"), -- Open the file in a new tabpage
          ["<leader>e"] = cb("focus_files"), -- Bring focus to the files panel
          ["<leader>b"] = cb("toggle_files"), -- Toggle the files panel.
        },
        file_panel = {
          ["j"] = cb("next_entry"), -- Bring the cursor to the next file entry
          ["<down>"] = cb("next_entry"),
          ["k"] = cb("prev_entry"), -- Bring the cursor to the previous file entry.
          ["<up>"] = cb("prev_entry"),
          ["o"] = cb("select_entry"),
          ["<2-LeftMouse>"] = cb("select_entry"),
          ["-"] = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
          ["S"] = cb("stage_all"), -- Stage all entries.
          ["U"] = cb("unstage_all"), -- Unstage all entries.
          ["X"] = cb("restore_entry"), -- Restore entry to the state on the left side.
          ["R"] = cb("refresh_files"), -- Update stats and entries in the file list.
          ["<S-Up>"] = actions.scroll_view(-20),
          ["<S-Down>"] = actions.scroll_view(20),
          ["<C-j>"] = cb("select_next_entry"),
          ["<C-k>"] = cb("select_prev_entry"),
          ["gf"] = cb("goto_file"),
          ["<cr>"] = cb("goto_file_tab"),
          ["i"] = cb("listing_style"), -- Toggle between 'list' and 'tree' views
          ["f"] = cb("toggle_flatten_dirs"), -- Flatten empty subdirectories in tree listing style.
          ["<leader>e"] = cb("focus_files"),
        },
        file_history_panel = {
          ["g!"] = cb("options"), -- Open the option panel
          ["<C-A-d>"] = cb("open_in_diffview"), -- Open the entry under the cursor in a diffview
          ["zR"] = cb("open_all_folds"),
          ["zM"] = cb("close_all_folds"),
          ["j"] = cb("next_entry"),
          ["<down>"] = cb("next_entry"),
          ["k"] = cb("prev_entry"),
          ["<up>"] = cb("prev_entry"),
          ["<cr>"] = cb("select_entry"),
          ["o"] = cb("select_entry"),
          ["<2-LeftMouse>"] = cb("select_entry"),
          ["<C-n>"] = cb("select_next_entry"),
          ["<C-p>"] = cb("select_prev_entry"),
          ["gf"] = cb("goto_file"),
          ["<C-w><C-f>"] = cb("goto_file_split"),
          ["<C-w>gf"] = cb("goto_file_tab"),
          ["<leader>e"] = cb("focus_files"),
          ["<leader>b"] = cb("toggle_files"),
        },
        option_panel = { ["<tab>"] = cb("select"), ["q"] = cb("close") },
      },
    })
  end,
}
