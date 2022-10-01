{
  description = "Rahul's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }: 
  let
    user = "rahul";
    system = "x86_64-linux";  # Which OS to use
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;

  in {
    nixosConfigurations = {
      framework = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit user; }; # Pass flake vars to external config files
        modules = [ 
          ./nixos/configuration.nix 
          ./hosts/framework/12th-gen-intel/hardware-configuration.nix 
          nixos-hardware.nixosModules.framework-12th-gen-intel
          
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit user; }; # Pass flake vars
            home-manager.users.${user} = {
              imports = [ ./nixos/home.nix ];
            };
          }
        ];
      };
    };
  };
}
