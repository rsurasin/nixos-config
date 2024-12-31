{ config, lib, pkgs, user, ... }:

{
  programs.firefox = {
    package = pkgs.firefox;
    enable = true;
    profiles = {
      default = {
        search = {
          default = "DuckDuckGo";
          engines = {
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              definedAliases = [ "@npkgs" ];
            };
            "Nix Options" = {
              urls = [{
                template = "https://search.nixos.org/options?";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              definedAliases = [ "@nopts" ];
            };
            "NixOS Wiki" = {
              urls = [{
                template = "https://nixos.wiki/index.php?search={searchTerms}";
              }];
              definedAliases = [ "@nwiki" ];
            };
            "Arch Wiki" = {
              urls = [{
                template = "https://wiki.archlinux.org/index.php?search={searchTerms}";
              }];
              definedAliases = [ "@awiki" ];
            };
            "Wikipedia (en)".metadata.alias = "@wiki";
          };
        };
        userChrome = ''
          #titlebar {
            appearance: none !important;
            height: 0px;
          }

          #main-window[tabsintitlebar="true"]:not([extradragspace="true"]) #TabsToolbar > .toolbar-items {
            opacity: 0;
            pointer-events: none;
          }

          #main-window:not([tabsintitlebar="true"]) #TabsToolbar {
              visibility: collapse !important;
          }
        '';
      };
    };
  };
}
