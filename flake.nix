{
  description = "My System Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";

    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
      };

      overlays = [
        (self: super: {
          unstable = pkgs-unstable;
          my = import ./pkgs { inherit pkgs; };
        })
      ];

      lib = nixpkgs.lib;
    in
    {
      home-manager.useGlobalPkgs = true;
      homeManagerConfigurations = {
        noobuser = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "noobuser";
          homeDirectory = "/home/noobuser";
          configuration = {
            imports = [
              ./users/noobuser/home.nix
              {
                nixpkgs.overlays = overlays;
              }
            ];
          };
        };
      };

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;

          modules = [
            ./system/configuration.nix
            {
              nixpkgs.overlays = overlays;
            }
          ];
        };
      };
    };
}
