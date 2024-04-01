# My Neovim config
Thanks to
- @ThePrimeagen's guide on ["0 to LSP" youtube video](https://www.youtube.com/watch?v=w7i4amO_zaE).
- @dmmulroy's [nvim config](https://github.com/dmmulroy/kickstart.nix/tree/main/config/nvim)

### In this setup
I had swap some plugins in this config such as using lazy as plugin manager, updated some plugins in my config like Harpoon and lsp-zero are using the up-to-date version, implemented CodeiumAI as my alternative to Copilot, and many more changes compare to @ThePrimegen's guide.

### How to install
1. Install Neovim
   ```bash
   curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
   chmod u+x nvim.appimage
   ./nvim.appimage
   ./nvim.appimage --appimage-extract
   ./squashfs-root/AppRun --version
   sudo mv squashfs-root /
   sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
   ```

2. Clone this repo
   ```bash
   cd ~/.config
   git clone https://github.com/wilson-shen/nvim-shen nvim
   ```

3. Run `nvim` to start Neovim and install the plugins by opening lazy plugin manager `<leader>l`, `Shift + i` to install.

4. Set your own CodeiumAI API key by running command `:Codeium Auth`, then open the provided link, copy your encrypted key and paste into the command.
