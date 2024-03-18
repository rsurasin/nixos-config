{
  description = "Rahul's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, hyprland, neovim-nightly, ... }@inputs:
  let
    user = "rahul";
    system = "x86_64-linux";  # Which OS to use
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
      overlays = [ inputs.neovim-nightly.overlay ];
    };
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config = { allowUnfree = true; };
      # waybar requires experimental features for wlr/workspaces
      overlays = [
        (self: super: {
          waybar = super.waybar.overrideAttrs (oldAttrs: {
            mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          });
        })
      ];
    };

    lib = nixpkgs.lib;

  in {
    nixosConfigurations = {
      framework = lib.nixosSystem {
        inherit system;
        specialArgs = { # Pass flake vars to external config files
          inherit user;
          inherit pkgs;
          inherit pkgs-unstable;
        };
        modules = [
          ./nixos/configuration.nix
          ./hosts/framework/12th-gen-intel/hardware-configuration.nix
          inputs.nixos-hardware.nixosModules.framework-12th-gen-intel

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { # Pass flake vars
              inherit user;
              inherit pkgs;
              inherit pkgs-unstable;
            };
            home-manager.users.${user} = {
              imports = [ ./nixos ];
            };
          }

          hyprland.nixosModules.default {
            programs.hyprland = {
              enable = true;
              package = inputs.hyprland.packages.${pkgs.system}.hyprland;
            };
          }
        ];
      };
    };
  };
}
 
