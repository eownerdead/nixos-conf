{
  description = "My System Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
      };

      overlays = [
        (self: super: {
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
