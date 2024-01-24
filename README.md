# My Neovim Configuration Setup Guide

Welcome to my Neovim configuration! Follow these steps to set up and enhance your Neovim experience.

## Prerequisites

Before diving into the configuration, ensure you have the following prerequisites installed:

1. **Node Packages:**
   Install neovim and tree-sitter node packages by running the following command:

   ```bash
   npm i -g neovim tree-sitter
   ```

2. **pynvim Package:**
   Install the pynvim package using pip:

   ```bash
   pip install -U pynvim
   ```

3. **Go Language Server (gopls):**
   For Go language support, you need to install the Go Language Server (gopls). Run the following command:

   ```bash
   go install golang.org/x/tools/gopls@latest
   ```

   After installation, set up the required environment variables in your shell configuration file (e.g., `.bashrc` or `.zshrc`):

   ```bash
   export GOPATH=~/go
   export GOROOT=/usr/local/go
   export PATH=$PATH:/usr/local/go/bin
   export PATH=$PATH:~/go/bin
   ```

   Ensure that the `python` command points to `python3` by adding the following alias:

   ```bash
   alias python=python3

   ```

4. **Install python3.10-venv:**
   Install the `python3.10-venv` package using the following command:

   ```bash
   sudo apt install python3.10-venv
   ```

5. **Ensure Neovim v0.9 and Above:**
   Ensure that you have Neovim version 0.9 or above installed. Check your Neovim version using:

   ```bash
   nvim --version
   ```

6. **Clone Configuration Repository:**
   Clone the Neovim configuration repository from `https://github.com/justicenyaga/my_nvim_config` to `~/.config/nvim`:

   ```bash
   git clone https://github.com/justicenyaga/my_nvim_config.git ~/.config/nvim
   ```

7. **_For WSL users_, Download win32yank to interact with windows clipboard:**

   Download win32yank binary here [https://github.com/equalsraf/win32yank/releases](https://github.com/equalsraf/win32yank/releases)
   then copy it to `/usr/local/bin`

   Add execution permissions

   ```bash
   chmod +x win32yank.exe
   ```

## Neovim Plugin Installation

1. **Open Neovim:**

   ```bash
   nvim
   ```

2. **Allow the plugins to load.** Once the plugins are installed, exit Neovim.

3. **Navigate to the ES7/Javascript/React snippets plugin directory:**

   ```bash
   cd ~/.local/share/nvim/lazy/vscode-es7-javascript-react-snippets
   ```

4. **Compile the plugin:**

   ```bash
   yarn install --frozen-lockfile && yarn compile
   ```

   This step is crucial for the proper functioning of the snippets plugin.

5. **_For WSL users_: To interact with system clipboard**, uncomment the wsl clipboard block on `~/.config/nvim/lua/justice/core/options.lua`

   ```lua
   -- vim.g.clipboard = {
   --   name = "win32yank-wsl",
   --   copy = {
   --     ["+"] = "win32yank.exe -i --crlf",
   --     ["*"] = "win32yank.exe -i --crlf",
   --   },
   --   paste = {
   --     ["+"] = "win32yank.exe -o --lf",
   --     ["*"] = "win32yank.exe -o --lf",
   --   },
   --   cache_enabled = true,
   -- }
   ```

That's it! Your Neovim environment is now configured and ready for use. Customize further based on your preferences, and happy coding!
