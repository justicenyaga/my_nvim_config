local util = require("justice.functions.util")

local api, keymap = vim.api, vim.keymap

local function jump_next()
  api.nvim_feedkeys(":silent! /^[?,M,A,D,U] ", "n", false)
  util.press_enter()
  api.nvim_feedkeys(":noh", "n", false)
  util.press_enter()
end

local function jump_prev()
  api.nvim_feedkeys(":silent! ?^[?,M,A,D,U] ", "n", false)
  util.press_enter()
  api.nvim_feedkeys(":noh", "n", false)
  util.press_enter()
end

local toggle_status = function()
  local ft = vim.bo.filetype
  if ft == "fugitive" then
    api.nvim_command("bd")
  else
    local fugitive_tab = util.get_tab_by_buf_name("fugitive", true)
    if fugitive_tab ~= -1 then
      api.nvim_set_current_tabpage(fugitive_tab)
    end
    api.nvim_command("silent! :Git")
    api.nvim_feedkeys(api.nvim_replace_termcodes("<C-w>T", false, true, true), "n", false)
    jump_next()
  end
end

return {
  "tpope/vim-fugitive",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local map_opts1 = { noremap = true, silent = true, nowait = true, buffer = false }
    local map_opts2 = { noremap = true }

    -- Status
    keymap.set("n", "<leader>gs", toggle_status, map_opts1) -- Toggle open/close of status tab

    -- Remote
    keymap.set("n", "<leader>gps", ":Git push<CR>", map_opts2) -- Git push
    keymap.set("n", "<leader>gPs", ":Git push --force<CR>", map_opts2) -- Git push --force
    keymap.set("n", "<leader>gpl", ":Git pull<CR>", map_opts2) -- Git pull
    keymap.set("n", "<leader>gPl", ":Git pull --force<CR>", map_opts2) -- Git pull --force
    keymap.set("n", "<leader>gpu", ":Git push -u<Space>", map_opts2) -- Populate git push set upstream
    keymap.set("n", "<leader>gra", ":Git remote add<Space>", map_opts2) -- Populate add remote
    keymap.set("n", "<leader>grd", ":Git remote remove<Space>", map_opts2) -- Populate remove
    keymap.set("n", "<leader>grl", ":Git remote -v<CR>", map_opts2) -- List all remotes verbosely
    keymap.set("n", "<leader>gor", ":Git remote<Space>", map_opts2) -- Populate "git remote "

    -- Work Tree (WT) & Staging
    keymap.set("n", "<leader>ga", ":Git add %:p<CR><CR>", map_opts2) -- Stage the buffer
    keymap.set("n", "<leader>gw", ":Gwrite<CR><CR>", map_opts2) -- Save and stage the buffer in WT, Checkout buffer in index
    keymap.set("n", "<leader>gm", ":GMove<Space>", map_opts2) -- Rename and stage the buffer

    -- Commit
    keymap.set("n", "<leader>gcc", ':Git commit -m ""<Left>', map_opts2) -- Populate commit with message
    keymap.set("n", "<leader>gca", ":Git commit --amend<CR>", map_opts2) -- Modify the previous commit (last commit)
    keymap.set("n", "<leader>gcm", ":Git commit<Space>", map_opts2) -- Populate git commit

    -- Branch
    keymap.set("n", "<leader>gbl", ":Git branch<CR>", map_opts2) -- List all the branches
    keymap.set("n", "<leader>gbv", ":Git branch -vv<CR>", map_opts2) -- List all the branches along with their remote tracking branches
    keymap.set("n", "<leader>gbo", ":Git branch<Space>", map_opts2) -- Populate "git branch "
    keymap.set("n", "<leader>gba", ":Git checkout -b<Space>", map_opts2) -- Populate create branch and checkout
    keymap.set("n", "<leader>gbr", ":Git branch -M<Space>", map_opts2) -- Populate rename branch
    keymap.set("n", "<leader>gbd", ":Git branch -d<Space>", map_opts2) -- Populate delete branch
    keymap.set("n", "<leader>gbD", ":Git branch -D<Space>", map_opts2) -- Populate force delete branch

    -- Checkout
    keymap.set("n", "<leader>gco", ":Git checkout<Space>", map_opts2) -- Populate "git checkout "

    -- Stash
    keymap.set("n", "<leader>gzz", ":Git stash -u<CR>", map_opts2) -- Push stash in both WT and index (including untracked files)
    keymap.set("n", "<leader>gzw", ":Git stash -u --keep-index<CR>", map_opts2) -- Push stash on WT only (including untracked files)
    keymap.set("n", "<leader>gza", ":Git stash apply<CR>", map_opts2) -- Apply the top most stash
    keymap.set("n", "<leader>gzA", ":Git stash apply<Space>", map_opts2) -- Populate apply stash
    keymap.set("n", "<leader>gzp", ":Git stash pop<CR>", map_opts2) -- Pop the top most stash
    keymap.set("n", "<leader>gzP", ":Git stash pop<Space>", map_opts2) -- Populate pop stash
    keymap.set("n", "<leader>gzd", ":Git stash drop<CR>", map_opts2) -- Drop the top most stash
    keymap.set("n", "<leader>gzD", ":Git stash drop<Space>", map_opts2) -- Populate drop stash
    keymap.set("n", "<leader>gzl", ":Git stash list<CR>", map_opts2) -- List all the stashes
    keymap.set("n", "<leader>gzo", ":Git stash<Space>", map_opts2) -- Populate "git stash "

    -- Rebase
    keymap.set("n", "<leader>gri", ":Git rebase -i<Space>", map_opts2) -- Populate interactive rebase
    keymap.set("n", "<leader>grn", ":Git rebase -i HEAD~<Space>", map_opts2) -- Populate interactive rebase with count from HEAD
    keymap.set("n", "<leader>grr", ":Git rebase --continue<CR>", map_opts2) -- Continue with current rebase
    keymap.set("n", "<leader>grx", ":Git rebase --abort<CR>", map_opts2) -- Abort the current rebase
    keymap.set("n", "<leader>gre", ":Git rebase --edit-todo<CR>", map_opts2) -- Edit todo list of current rebase
    keymap.set("n", "<leader>gro", ":Git rebase<Space>", map_opts2) -- Populate "git rebase "

    -- Merge
    keymap.set("n", "<leader>gmo", ":Git merge<Space>", map_opts2) -- Populate "git merge "
    keymap.set("n", "<leader>gmt", ":Git mergetool<CR>", map_opts2) -- Open merge tool **I prefer to use diffview to easily fix merge conficts**
    keymap.set("n", "<leader>gmr", ":Git merge --continue<CR>", map_opts2) -- Continue with the merge
    keymap.set("n", "<leader>gmx", ":Git merge --abort<CR>", map_opts2) -- Abort merge

    -- Cherry Pick
    keymap.set("n", "<leader>gyi", ":Git cherry-pick<Space>", map_opts2) -- Populate "git cherry-pick "
    keymap.set("n", "<leader>gyr", ":Git cherry-pick --continue<CR>", map_opts2) -- Continue with the cherry-pick (after fixing conficts)
    keymap.set("n", "<leader>gyx", ":Git cherry-pick --abort<CR>", map_opts2) -- Abort cherry-pick (due to conflicts)

    -- Reset
    keymap.set("n", "<leader>grh", ":Git reset HEAD^<CR>", map_opts2) -- Reset the last commit
    keymap.set("n", "<leader>gRh", ":Git reset --hard HEAD^<CR>", map_opts2) -- Hard reset the last commit
    keymap.set("n", "<leader>gri", ":Git reset HEAD~<Space>", map_opts2) -- Populate reset from a given commit count from HEAD
    keymap.set("n", "<leader>gRi", ":Git reset --hard HEAD~<Space>", map_opts2) --  Populate hard reset from a given commit count from HEAD
    keymap.set("n", "<leader>grO", ":Git reset<Space>", map_opts2) -- Populate git reset

    -- Initialize a repo
    keymap.set("n", "<leader>gi", ":Git init<CR>", map_opts2) -- Create a repo
  end,
  jump_next = jump_next,
  jump_prev = jump_prev,
}
