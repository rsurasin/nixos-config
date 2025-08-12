{ config, lib, pkgs, pkgs-unstable, user, ... }:

{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    stateVersion = "24.11"; # Don't touch

    packages = with pkgs; [
      # Dev Tools
      fish                # Shell
      starship            # Shell Prompt
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
      yazi                # File manager
      gcc                 # GNU Compiler Collection
      gnumake             # Controls the generations of executables
      cmake               # Cross-platform open-source build system generator
      git-crypt           # Encryption for git
      zoxide              # Smarter cd

      pkgs-unstable.tree-sitter    # Parser Generator Tool
      pkgs-unstable.nodejs         # JS runtime environment
      pkgs-unstable.claude-code    # Claude AI Agent

      # Utilities
      btop                # System Monitoring

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

      # WSL Utilities
      wslu
    ];
  };

  programs = {
    # Let Home Manager install and manage itself
    home-manager.enable = true;

    # Fish config
    fish.enable = true;
    fish.shellInit = builtins.readFile ../../home/config/fish/config.fish;

    # Fish autocomplete
    man.generateCaches = true;

    # Fish plugins
    fish.plugins = [
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
    tmux.extraConfig = builtins.readFile ../../home/tmux.conf;

    bat = {
      enable = true;
      config = {
        theme = "Catppuccin-mocha"; # Themes: gruvbox-dark, Dracula
      };
      themes = {
        # Name needs to match w/ theme above
        Catppuccin-mocha = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
            sha256 = "6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
          };
          file = "/Catppuccin-mocha.tmTheme";
        };
      };
    };
  };

  # Fish config (functions)
  home.file.".config/fish/functions/key-bindings.fish".source = ../../home/config/fish/functions/key-bindings.fish;

  # Starship config
  home.file.".config/starship.toml".source = ../../home/config/starship.toml;

  # Tmux config
  home.file.".tmux.conf".source = ../../home/tmux.conf;

  # Gitconfig
  # home.file.".gitconfig".source = ../../home/gitconfig;

  # Neovim config
  home.file.".config/nvim".source = ../../home/config/nvim;
  home.file.".config/nvim".recursive = true;
}
