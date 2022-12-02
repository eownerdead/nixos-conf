{
  description = "My System Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nur.url = "github:nix-community/NUR";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:Mic92/nix-index-database";
    emacs.url = "github:nix-community/emacs-overlay";
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , nur
    , utils
    , home-manager
    , nix-index-database
    , emacs
    , ...
    }:
    utils.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      sharedOverlays = [
        nur.overlay
        emacs.overlay
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
      };

      nix = {
        # generateRegistryFromInputs = true;
        generateNixPathFromInputs = true;
        linkInputs = true;
      };

      hosts = {
        nixos = {
          system = "x86_64-linux";
          channelName = "nixpkgs";
          modules = [
            ./hosts/nixos/configuration.nix
            home-manager.nixosModules.home-manager
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
          specialArgs = { inherit nixpkgs; };
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
          specialArgs = { inherit nixpkgs; };
        };
      };

      outputsBuilder = channels: {
        formatter = channels.nixpkgs.nixpkgs-fmt;
      };
    };
}
