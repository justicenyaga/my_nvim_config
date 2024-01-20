# Tmux Configuration

Follow these steps to set up and enhance your Tmux experience:

1. **Copy the `.tmux.conf` file to your home directory:**

   Copy the configuration file using the following command:

   ```bash
   cp path/to/your/.tmux.conf ~/.tmux.conf
   ```

2. **Install Tmux Plugin Manager (tpm):**

   Clone the Tmux Plugin Manager repository to your local machine:

   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

3. **Create a Tmux session:**

   Start a new Tmux session with a specific name (replace `SessionName` with your desired name):

   ```bash
   tmux new -s SessionName
   ```

4. **Attach to the Tmux session:**

   Attach to an existing Tmux session using the following command (replace `SessionName` with the name of your session):

   ```bash
   tmux attach -t SessionName
   ```

5. **Reload the Tmux configuration file:**

   Press your Tmux prefix key (the configuration file uses `<C-n>`) followed by `r` to reload the configuration file:

   ```bash
   <C-n>r
   ```

   Note: Replace `<C-n>` with the actual key bind for your prefix.

6. **Install Tmux plugins:**

   While inside a Tmux session, install plugins by pressing your Tmux prefix key followed by `I` (uppercase):

   ```bash
   <C-n>I
   ```

   Again, replace `<C-n>` with the actual key bind for your prefix.

That's it! Your Tmux environment is now configured with the specified settings and plugins. Customize further based on your preferences.
