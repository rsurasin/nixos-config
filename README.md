# NixOS Config
---
## Description
In progress
---
## NixOS Quick Start Guide
### Build System
`nixos-rebuild build --flake .#<hostname>`

### Switch System
`sudo nixos-rebuild switch --flake .#<hostname>`

- Used to install things

### Upgrade System
`nix flake update --recreate-lock-file`

### Helpful for diagnostic
`sudo nixos-rebuild switch --flake .#framework --option eval-cache false --show-trace`
---
## NixOS Upgrade System & Packages
