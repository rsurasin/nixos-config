# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, pkgs, pkgs-unstable, user, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # ./hardware-configuration.nix
    ];

  # Enable Flakes
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "JetBrainsMono" ]; })
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 20;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-1767ddfc-5f2e-4735-97e3-393b031db9a3".device = "/dev/disk/by-uuid/1767ddfc-5f2e-4735-97e3-393b031db9a3";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
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

  # Console config
  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "ter-i32b";
    keyMap = "us";
    # useXkbConfig = true; # use xkbOptions in tty
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable Wayland and Hyprland
  services.xserver.displayManager.gdm = {
    wayland = true;
  };
  programs.hyprland = {
    enable = true;
    # Set the flake package
    package = pkgs.hyprland;
    # Set the portal package to make sure they are in sync - Screen Sharing
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.displayManager.defaultSession = "hyprland";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "ctrl:nocaps"; # map caps to ctrl
  };

  # Intel GPU Settings
  services.xserver.videoDrivers = [ "modesetting" ];
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" ];
  hardware.graphics = {
    enable = true;
    #extraPackages = with inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}; [
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true; # For professional audio software

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;

    wireplumber.enable = true;
  };

  # High Quality Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.hsphfpd.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.libinput.touchpad.naturalScrolling = true;

  # Power Management - Framework Laptop
  services.tlp.enable = true;
  powerManagement.powertop.enable = true;
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  # Fingerprint - Framework Laptop
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.swaylock = {};
  security.pam.services.swaylock.fprintAuth = true;
  security.polkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Rahul Surasinghe";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "camera" ];
    shell = pkgs.fish;
    # packages = with pkgs; [
    #  firefox
    #  thunderbird
    # ];
  };
  programs.fish.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    xdg-utils
    pkgs-unstable.wayland
    pkgs-unstable.qt6.qtwayland         # QT6 Framework
    pkgs-unstable.wayland-utils         # Display Info about Protocols
    pkgs-unstable.wayland-scanner       # Wayland Protocol
    pkgs-unstable.wayland-protocols     # Wayland Protocol Extensions
    pkgs-unstable.glfw-wayland          # Managing Input
    pkgs-unstable.wev                   # Wayland Event Viewer
    pkgs-unstable.wl-clipboard          # Copy/Paste Utilities
    pkgs-unstable.wlr-randr             # Output/Display Configuration Tool
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [8081 5173];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
