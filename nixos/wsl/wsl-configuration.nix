{ config, lib, inputs, pkgs, pkgs-unstable, user, ... }:

{
  # Enalbe WSL compatibility
  wsl = {
    enable = true;
    defaultUser = user;
    startMenuLaunchers = true;

    # Enable systemd (optional, but recommended)
    wslConf = {
      automount.root = "/mnt";
      interop.appendWindowsPath = false;
      network.generateHosts = false;
    };
  };

  # Enable Flakes
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # fish autocomplete for system packages
  environment.pathsToLink = [
    "/share/fish"
  ];

  # Installing Fonts
  fonts = {
    #fontconfig.enable = true;
    packages = with pkgs; [
      jetbrains-mono
      roboto
      nerd-fonts.symbols-only
      nerd-fonts.jetbrains-mono
    ];
  };

  # Set time zone
  time.timeZone = "America/New_York";

  # Select internationlisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define user account
  users.users.${user} = {
    isNormalUser = true;
    description = "Rahul Surasinghe";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  # System packages (CLI tools only, no GUI apps)
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    xdg-utils
    wslu # WSL utilities
  ];

  # Enable systemd user services
  services.dbus.enable = true;

  # Disable hardware-specific features that don't work in WSL
  hardware.bluetooth.enable = false;
  services.fprintd.enable = false;
  services.tlp.enable = false;
  powerManagement.enable = false;

  # This value determins the NixOS release
  # Don't touch
  system.stateVersion = "24.11";
}
