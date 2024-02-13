# My Neovim Configuration Setup Guide

Welcome to my Neovim configuration! Follow these steps to set up and enhance your Neovim experience.
![My Neovim](nvim.png)

## Prerequisites

Before diving into the configuration, ensure you have the following prerequisites installed:

1. **Ensure you have Neovim v0.9 and Above:**
   Ensure that you have Neovim version 0.9 or above installed. Check your Neovim version using:

   ```bash
   nvim --version
   ```

2. **Install python3.10-venv:**
   Install the `python3.10-venv` package using the following command:

   ```bash
   sudo apt install python3.10-venv
   ```

3. **Node Packages:**
   Install neovim and tree-sitter node packages by running the following command:

   ```bash
   npm i -g neovim tree-sitter
   ```

4. **pynvim Package:**
   Install the pynvim package using pip:

   ```bash
    python3 -m pip install pynvim
   ```

   Ensure that the `python` command points to `python3` by adding the following alias in your `.bashrc` or `.zshrc`:

   ```bash
   alias python=python3

   ```

5. **Install ripgrep:**

   For telescope live_grep to work, you need to have ripgrep and fd packages. Install them using:

   ```bash
   sudo apt install ripgrep fd-find
   ```

6. **Go Language Server (gopls):**
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

7. **java-debug**

   To enable debugging java programs, you need to load the `java-debug` extension. Install it using to your neovim data folder `~/.local/share/nvim/` using the following commands:

   ```bash
   git clone https://github.com/microsoft/java-debug.git ~/.local/share/nvim/java-debug
   cd ~/.local/share/nvim/java-debug
   ./mvnw clean install
   ```

8. **Clone Configuration Repository:**
   Clone my Neovim configuration repository to `~/.config/nvim`:

   ```bash
   git clone https://github.com/justicenyaga/my_nvim_config.git ~/.config/nvim
   ```

9. **_For WSL users_, Download win32yank to interact with windows clipboard:**

   Download win32yank binary here [https://github.com/equalsraf/win32yank/releases](https://github.com/equalsraf/win32yank/releases)
   then copy it to `/usr/local/bin`

   Add execution permissions

   ```bash
   chmod +x win32yank.exe
   ```

   Uninstall `xclip` if you have it installed to avoid potential conflit as it would be used as the default:

   ```bash
   sudo apt remove xclip
   ```

## Neovim Plugin Installation

1. **Open Neovim:**

   ```bash
   nvim
   ```

2. **Allow the plugins to load.**

   You can issue the command `:Lazy` to view the progress

   Once the plugins are installed, exit Neovim.

3. **Compile the ES7/Javascript/React snippets plugin:**

   ```bash
   cd ~/.local/share/nvim/lazy/vscode-es7-javascript-react-snippets
   yarn install --frozen-lockfile && yarn compile
   ```

   This step is crucial for the proper functioning of the snippets plugin.

4. **Customize Your Language Server Protocol (LPS), Linters and Formatters Installation:**

   Open up Mason using the command `:Mason` to install your preferred LPS, Linters and Formatters and tailor it to your specific needs. This allows you to customize and optimize your Language Server Protocol setup for an enhanced coding experience.

5. **nvim-jdtls Configuration**

   Checkout [my nvim-jdtls blog post](https://justicenyaga.me/posts/202402-configuring-java-lsp-for-neovim-with-nvim-jdtls) on how to configure the Java LSP

6. **_For WSL users_: To interact with system clipboard**, uncomment the wsl clipboard block on `~/.config/nvim/lua/justice/core/options.lua`

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

## Recommendations

Congratulations on setting up your Neovim environment! If you're looking to further enhance your terminal experience, I highly recommend checking out [my tmux configuration post](http://justicenyaga.me/posts/202401-my-tmux-configuration/). Tmux is a powerful terminal multiplexer that allows you to organize and manage multiple terminal sessions effortlessly.

Discover how to optimize your workflow, split your terminal into panes, and efficiently navigate through different sessions. Tmux can significantly boost your productivity and provide a seamless terminal experience alongside your Neovim setup.

Happy coding, and may your terminal sessions be ever productive!
