{
  description = "My System Config";

  inputs = {
    unstable.url = "nixpkgs/nixos-unstable";
    nur.url = github:nix-community/NUR;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = inputs@{ self, unstable, nur, utils, home-manager, ... }:
    utils.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      sharedOverlays = [ nur.overlay ];

      channels = {
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
            ./system/configuration.nix
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
      };
    };
}
