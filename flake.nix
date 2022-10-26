{
  description = "My System Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    unstable.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };
    nix-index-database.url = "github:Mic92/nix-index-database";
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , unstable
    , nur
    , utils
    , home-manager
    , home-manager-unstable
    , nix-index-database
    , ...
    }:
    utils.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      sharedOverlays = [
        nur.overlay
        (self: super: with nix-index-database.legacyPackages.x86_64-linux; {
          inherit database;
        })
      ];

      channels = {
        nixpkgs = {
          overlaysBuilder = channels: [
            (self: super: { my = import ./pkgs { pkgs = channels.nixpkgs; }; })
          ];
        };
        unstable = {
          overlaysBuilder = channels: [
            (self: super: { my = import ./pkgs { pkgs = channels.unstable; }; })
          ];
        };
      };

      nix = {
        generateRegistryFromInputs = true;
        generateNixPathFromInputs = true;
        linkInputs = true;
      };

      hosts = {
        nixos = {
          system = "x86_64-linux";
          channelName = "unstable";
          modules = [
            ./hosts/nixos/configuration.nix
            home-manager-unstable.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users = {
                  noobuser = import (./. + "/users/noobuser@nixos/home.nix");
                };
              };
            }
            {
              nixpkgs.config = {
                allowUnfreePredicate = pkg:
                  builtins.elem (nixpkgs.lib.getName pkg) [
                    "nvidia-x11"
                    "nvidia-settings"
                    "googleearth-pro"
                  ];
                allowInsecurePredicate = pkgs:
                  builtins.elem (nixpkgs.lib.getName pkgs) [
                    "googleearth-pro"
                  ];
              };
            }
          ];
          specialArgs = {
            nixpkgs = unstable;
          };
        };

        home-server = {
          system = "x86_64-linux";
          channelName = "nixpkgs";
          modules = [
            ./hosts/home-server/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users = {
                  noobuser = import (./. + "/users/noobuser@home-server/home.nix");
                };
              };
            }
          ];
          specialArgs = {
            inherit nixpkgs;
          };
        };
      };

      outputsBuilder = channels: {
        formatter = channels.unstable.nixpkgs-fmt;
      };
    };
}
