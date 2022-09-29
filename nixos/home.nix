{ config, pkgs, ... }:

{
  home = {
    username = "rahul";
    homeDirectory = "/home/rahul";

    stateVersion = "22.05"; # Don't touch

    packages = with pkgs; [
      kitty
      neovim
      firefox
      bitwarden
      discord
      spotify
      signal-desktop
      obsidian
    ];
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
