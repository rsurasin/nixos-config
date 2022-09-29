# NixOS Config
---
## Description
In progress
---
## Commands
### Build System
`nixos-rebuild build --flake .#<hostname>`
### Switch System
`sudo nixos-rebuild switch --flake .#<hostname>`
### Upgrade System
`nix flake update --recreate-lock-file`
