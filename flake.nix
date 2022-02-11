{
  description = "My System Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
      };

      lib = nixpkgs.lib;
    in
    {
      homeManagerConfigurations = {
        noobuser = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "noobuser";
          homeDirectory = "/home/noobuser";
          configuration = {
            imports = [
              ./users/noobuser/home.nix
            ];
          };
        };
      };

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;

          modules = [
            ./system/configuration.nix
          ];
        };
      };
    };
}
