{
  description = "My System Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    unstable.url = "nixpkgs/nixos-unstable";
    nur.url = github:nix-community/NUR;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = inputs@{ self, nixpkgs, unstable, nur, utils, home-manager, ... }:
    utils.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      sharedOverlays = [ nur.overlay ];

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

      hosts = {
        nixos = {
          system = "x86_64-linux";
          channelName = "unstable";
          modules = [
            ./hosts/nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users = {
                  noobuser = import ./users/noobuser/home.nix;
                };
              };
            }
          ];
        };

        home-server = {
          system = "x86_64-linux";
          channelName = "nixpkgs";
          modules = [
            ./hosts/home-server/configuration.nix
          ];
        };
      };
    };
}
