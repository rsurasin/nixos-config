{ config, lib, pkgs, pkgs-unstable, user, ... }:

{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    stateVersion = "22.05"; # Don't touch

    # Consistent Cursor
    pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 32;
      gtk.enable = true;
      x11.enable = true;
    };

    packages = with pkgs; [
      # Dev Tools
      fish                # Shell
      starship            # Shell Prompt
      pkgs-unstable.ghostty               # Terminal
      neovim              # Editor
      tmux                # Terminal Multiplexer
      fzf                 # Fuzzy Finder
      bat                 # cat replacement
      ripgrep             # grep replacement
      fd                  # find replacement
      eza                 # ls replacement
      tealdeer            # Simplified man pages
      tree                # Show file structure
      fpp                 # Presents files for selection
      ranger              # File manager
      gcc                 # GNU Compiler Collection
      gnumake             # Controls the generations of executables
      cmake               # Cross-platform open-source build system generator
      git-crypt           # Encryption for git

      pkgs-unstable.tree-sitter    # Parser Generator Tool
      pkgs-unstable.nodejs         # JS runtime environment

      # Utilities
      brightnessctl       # Control device brightness
      playerctl           # Control media player
      btop                # System Monitoring

      # Wayland
      pkgs-unstable.foot                  # Terminal
      pkgs-unstable.fuzzel                # App Launcher
      pkgs-unstable.mako                  # Simple Notification Daemon
      pkgs-unstable.grim                  # Screenshot cli & Screensharing
      pkgs-unstable.slurp                 # Monitor selection & Screensharing
      pkgs-unstable.waybar                # Customizable bar
      pkgs-unstable.swaybg                # Wallpaper
      pkgs-unstable.cliphist              # Clipboard manager
      pkgs-unstable.wf-recorder           # Screen Recording
      pkgs-unstable.swayidle              # Idle management daemon
      pkgs-unstable.swaylock-effects      # Screen Lock
      pkgs-unstable.wlogout               # Logout Menu

      # Language Servers
      rust-analyzer
      pyright
      lua-language-server
      typescript-language-server
      vscode-langservers-extracted        # eslint, html, css, & json
      dockerfile-language-server-nodejs
      yaml-language-server
      gopls
      nil # lsp for nix
      # TODO: Package graphql-language-service-cli

      # Fonts
      jetbrains-mono
      roboto

      # Applications
      bitwarden           # Password Manager
      discord             # Messenging App
      spotify             # Music
      signal-desktop      # Messenging App
      flameshot           # Screenshot
      mpv                 # Video Player
      imv                 # Image Viewer
      sioyek              # PDF Viewer
      pavucontrol         # Volume Control GUI
      pkgs-unstable.obsidian            # Notes
    ];
  };

  programs = {
    # Let Home Manager install and manage itself
    home-manager.enable = true;

    # Fish config
    fish.enable = true;
    fish.shellInit = builtins.readFile ../home/config/fish/config.fish;

    # Fish autocomplete
    man.generateCaches = true;

    # Fish plugins
    fish.plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
          sha256 = "+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
        };
      }
      {
        # base16 themes work w/ tmux
        # BUG: https://github.com/tomyun/base16-fish/issues/7
        name = "base16-fish";
        src = pkgs.fetchFromGitHub {
          owner = "rsurasin";
          repo = "base16-fish";
          rev = "880e650b94c8459c9aa5559ec715e5540a7fa661";
          sha256 = "NUYm4qPyC4L/poE+hwyxfC5MnNhfEx1RBmRhb2XnVKc=";
        };
      }
    ];

    # Starship Prompt
    starship.enable = true;

    # Tmux
    tmux.enable = true;
    tmux.extraConfig = builtins.readFile ../home/tmux.conf;

  };

  # Fish config (functions)
  home.file.".config/fish/functions/key-bindings.fish".source = ../home/config/fish/functions/key-bindings.fish;

  # Starship config
  home.file.".config/starship.toml".source = ../home/config/starship.toml;

  # Ghostty config
  home.file.".config/ghostty".source = ../home/config/ghostty;
  home.file.".config/ghostty".recursive = true;

  # Tmux config
  home.file.".tmux.conf".source = ../home/tmux.conf;

  # Neovim config
  home.file.".config/nvim".source = ../home/config/nvim;
  home.file.".config/nvim".recursive = true;

  # Hyprland config
  home.file.".config/hypr".source = ../home/config/hypr;
  home.file.".config/hypr".recursive = true;

  # Waybar config
  home.file.".config/waybar".source = ../home/config/waybar;
  home.file.".config/waybar".recursive = true;

  # Swaylock config
  home.file.".config/swaylock".source = ../home/config/swaylock;
  home.file.".config/swaylock".recursive = true;
}
