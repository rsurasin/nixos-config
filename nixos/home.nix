{ config, lib, pkgs, user, ... }:

{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    stateVersion = "22.05"; # Don't touch

    packages = with pkgs; [
      # Dev Tools
      fish                # Shell
      starship            # Shell Prompt
      kitty               # Terminal
      neovim              # Editor
      tmux                # Terminal Multiplexer
      fzf                 # Fuzzy Finder
      bat                 # cat replacement
      ripgrep             # grep replacement
      fd                  # find replacement
      exa                 # ls replacement
      tealdeer            # Simplified man pages
      tree                # Show file structure
      urlview             # Extract urls from text
      fpp                 # Presents files for selection
      gcc                 # GNU Compiler Collection

      # Language Servers
      rust-analyzer
      nodePackages.pyright
      nodePackages.typescript-language-server
      sumneko-lua-language-server
      nodePackages.vscode-langservers-extracted        # html, css, & json
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.yaml-language-server
      gopls
      rnix-lsp
      # TODO: Package graphql-language-service-cli

      # Fonts
      jetbrains-mono
      roboto

      # Applications
      firefox             # Browser
      bitwarden           # Password Manager
      discord             # Messenging App
      spotify             # Music
      signal-desktop      # Messenging App
      obsidian            # Notes
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
          owner = "twiggley";
          repo = "base16-fish";
          rev = "3d5855be510e94156b4c9bde218d0d5a2bd81b7b";
          sha256 = "kAq9LAsgjIBwEp3f1BMpEXohhXg8/EDAfH0RICIbgsA=";
        };
      }
    ];

    # Starship Prompt
    starship.enable = true;

    # Kitty
    kitty.enable = true;

    # Tmux
    tmux.enable = true;
    tmux.extraConfig = builtins.readFile ../home/tmux.conf;

  };

  # Fish config (functions)
  home.file.".config/fish/functions/key-bindings.fish".source = ../home/config/fish/functions/key-bindings.fish;

  # Starship config
  home.file.".config/starship.toml".source = ../home/config/starship.toml;

  # Kitty config
  home.file.".config/kitty".source = ../home/config/kitty;
  home.file.".config/kitty".recursive = true;

  # Tmux config
  home.file.".tmux.conf".source = ../home/tmux.conf;

  # Neovim config
  home.file.".config/nvim".source = ../home/config/nvim;
  home.file.".config/nvim".recursive = true;

  # i3 config
  home.file.".config/i3".source = ../home/config/i3;
  home.file.".config/i3".recursive = true;

}
