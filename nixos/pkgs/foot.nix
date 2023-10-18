{ config, lib, pkgs, pkgs-unstable, user, ... }:

{
  programs.foot = {
    package = pkgs-unstable.foot;
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "JetBrainsMono Nerd Font:size=9.5";
        dpi-aware = "yes";
      };

      scrollback = {
        lines = "100000";
      };

      cursor = {
        # Note: Themes - https://codeberg.org/dnkl/foot/src/branch/master/themes
        # Gruvbox
        # color = "282828 ebdbb2";
        # Catppuccin
        color = "1A1826 D9E0EE";
      };

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
