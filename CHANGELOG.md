## Releases
### v1.0
- Initial NixOS (22.11) config
- Flake w/ home-manager and works w/ Framework laptop 12th gen intel

### v1.0.1
- Hotfix: Set hsphfpd to false

### v2.0 - Wayland Overhaul
- Switch from X11 to Wayland
- Use Hyprland as Window Manager / Compositor (replace i3)
- Use swaylock, swayidle, wlogout, waybar
- Mako as notification daemon
- Foot as new terminal (replace Kitty)
- Fuzzel as app launcher
- Other utilities such as cliphist, grim, etc.

### v2.1 - NixOS 23.11
- Upgrade to NixOS v23.11
- Upgrade all packages (Home Manager, Firefox, Neovim, etc.)
- Upgrade all Neovim plugins
- Not using Neovim nightly due to bugs with Hydra Plugin
- Add Copilot plugin for Neovim
- Enable screensharing w/ Wayland (doesn't work w/ Firefox)
- Enable `NIXOS_OZONE_WL` to prevent electron apps from being blurry

### v2.2 - NixOS 24.05
- Upgrade to NixOS v24.05
- Add new abbreviations to fish shell
- hyprland:
    - Enable options for screen sharing
    - BUG: hyprland - can't go fullscreen on YouTube w/ Firefox (check git commit)
- tmux: `urlview` is not supported anymore
- Neovim: add autocmds for formatting filetypes
- Allow listening on TCP ports for development purposes
