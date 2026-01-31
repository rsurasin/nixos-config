{
  description = "Rahul's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # WSL support
    # WSL-specific nixpkgs (25.11 for WSL compatibility)
    nixpkgs-wsl.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager-wsl = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-wsl";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs-wsl";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-wsl, nixpkgs-unstable, nixos-hardware, home-manager, home-manager-wsl, nixos-wsl, hyprland, neovim-nightly, ... }@inputs:
  let
    user = "rahul";
    system = "x86_64-linux";  # Which OS to use

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
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

    # Package sets for WSL
    pkgs-wsl = import nixpkgs-wsl {
      inherit system;
      config = { allowUnfree = true; };
    };
    pkgs-unstable-wsl = import nixpkgs-unstable {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;
    lib-wsl = nixpkgs-wsl.lib;

  in {
    nixosConfigurations = {
      # Framework laptop with newer NixOS (25.05)
      framework = lib.nixosSystem {
        inherit system;
        specialArgs = { # Pass flake vars to external config files
          inherit user;
          inherit pkgs-unstable;
          inherit inputs;
        };
        modules = [
          ./nixos/configuration.nix
          ./hosts/framework/12th-gen-intel/hardware-configuration.nix
          inputs.nixos-hardware.nixosModules.framework-12th-gen-intel

          home-manager.nixosModules.home-manager {
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { # Pass flake vars
              inherit user;
              inherit pkgs-unstable;
              inherit inputs;
            };
            home-manager.users.${user} = {
              imports = [ ./nixos ];
            };
          }
        ];
      };

      # WSL configuration for NixOS
      wsl = lib-wsl.nixosSystem {
        inherit system;
        pkgs = pkgs-wsl;
        specialArgs = { # Pass flake vars to external config files
          inherit user;
          inherit inputs;
          pkgs-unstable = pkgs-unstable-wsl;  # Use unstable packages compatible with 24.11
        };
        modules = [
          nixos-wsl.nixosModules.default
          ./nixos/wsl/wsl-configuration.nix

          home-manager-wsl.nixosModules.home-manager {
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { # Pass flake vars
              inherit user;
              inherit inputs;
              pkgs-unstable = pkgs-unstable-wsl;
            };
            home-manager.users.${user} = {
              imports = [ ./nixos/wsl/wsl-home.nix ];
            };
          }
        ];
      };
    };
  };
}
