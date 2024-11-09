{ config, lib, pkgs, pkgs-unstable, user, ... }:

{
  imports = [
    ./home.nix # Installs common pkgs (& unstable), configures un-nixified pkgs (e.g., Neovim)
    ./pkgs/bat.nix
    ./pkgs/foot.nix
  ];
}
