# NixOS Config
---
## Description
Useful Nix stuff that I learned to manage my system over the years. Also, contains
my neovim keybindings and what they do.

---
## NixOS Quick Start Guide
### Build System
`nixos-rebuild build --flake .#<hostname>`

### Rebuild System
`sudo nixos-rebuild switch --flake .#<hostname>`

- Used to install things
- *IMPORTANT:* Remove home-manager `.backup` files in `~/.config` and `~/.mozilla`

### Upgrade System
`sudo nix flake update`

- Create a new flake.lock with updated packages from nixos.pkgs

`nixos-version`

- Show the version of NixOS

### Channels
Channels are redundant when we are using flake to declaratively managing the system
and packages.

`sudo nix-channel --update`

- Update the nixpkgs channel (will affect imperatively installing pkgs with `nix-shell`)

`sudo nix-channel --list`

- Check current channel in use

`sudo nix-channel --remove <channel-alias>` -> `sudo nix-channel --remove nixos`

- Remove a channel

`sudo nix-channel --add https://nixos.org/channels/channel-name nixos`

- Adding a primary channel

### Helpful for diagnostic
`sudo nixos-rebuild switch --flake .#framework --option eval-cache false --show-trace`

---
## NixOS Upgrade System & Packages
### Upgrade Only Packages
1. `sudo nix flake update`
2. `sudo nixos-rebuild switch --flake .#framework`
3. `sudo reboot`

### Upgrade Entire OS
1. Edit the `flake.nix`:
    - Change `nixpkgs.url` to latest version of NixOS
    - Change `home-manger.url` to the matching version of NixOS release
2. `sudo nix flake update`
3. `sudo nixos-rebuild switch --flake .#framework`
    - Most likely there will be breaking changes where you will need to update
      the `flake.nix` or `nixos/configuration.nix` and even config files for devtools
4. `sudo reboot`
5. `nixos-version`

---
## Neovim keybindings
`<leader>` key is `<space>`.

### General
`U` - Redo
`<leader>*` - Replace word under cursor and every occurance of it going forwards
`<leader>#` - Replace word under cursor and every occurance of it going backwards

`<C-h>` + `<C-j>` + `<C-k>` + `<C-l>` - Vim motions for tmux panes and neovim buffers

### Buffers
`<leader><Tab>` - Switch to last used buffer
`<leader>d` - Delete buffer

### Telescope
#### Files & Paths
`<leader>ff` - Find files
`<leader>fp` - Find projects
`<leader>fc` - Change to any directory (like `cd`)
#### Ripgrep search
`<leader>rf` - Grep for any string recursively within directory (like `rg`)
`<leader>rs` - Grep for string under cursor
#### Git Integration
`<leader>gf` - Find git files
`<leader>gc` - Search through git commits
`<leader>gC` - Search through git commits for current buffer/file
#### Buffers
`<leader>ls` - Cycle active buffers
`<leader>rb` - Grep current buffer (like `<C-f>` in a web browser)
#### Help tags
`<leader>fh` - Search help tags
#### LSP
`<gr>` - Find lsp references of item under cursor (e.g., everywhere a variable is referenced)
`<gI>` - Find lsp implementation of item under cursor (e.g., everywhere an interface is implemented)
`<leader>wd` - Show all lsp documenent symbols (e.g., shows all classes, functions, variables, etc.)
`<leader>ww` - Show all lsp dynamic workspace symbols (e.g., same as above but for an entire workspace)
#### Undotree
`<leader>u` - Bring up the undotree

### LSP
`gD` - Go to declaration (e.g., go to where symbol is originally declared)
`gd` - Go to definition (e.g., where a symobol's implementation/behavior is defined)
`K` - Provide context about the symbol where your cursor is over
`<C-h>` - Signature help when in insert mode
`gT` - Go to type definition (e.g., go to symbol's type definition like the class or interface it uses)
`<leader>rn` - Rename all instances of a symbol
`<leader>ca` - Code action suggested by lsp for errors and warnings

`<leader>e` - Open diagnostic for error/warning over cursor
`<leader>[` - Go to previous diagnostic
`<leader>]` - Go to next diagnostic
`<leader>q` - Populate the location list with all diagnostic information (helpful)
`<space>f` - Format buffer based on lsp recommendation


### Hydra
#### Buffers
`<leader>b` - Opens hydra menu for buffer cycling
`<C-w>` - Opens hydra menu for buffer resizing
#### Git Integration
`<leader>g` - Opens hydra menu to do git operations with gitsigns or fugitive
