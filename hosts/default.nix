{ self, inputs, withSystem, ... }:
{
  flake.nixosConfigurations = {
    nixos = withSystem "x86_64-linux" ({ pkgs, system, ... }:
      inputs.nixpkgs.lib.nixosSystem rec {
        inherit system;
        specialArgs = { inherit pkgs; };
        modules = [
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.noobuser = import (../. + "/users/noobuser@nixos");
            };
          }
          ./nixos/configuration.nix
        ];
      });

    home-server = withSystem "x86_64-linux" ({ pkgs, system, ... }:
      inputs.nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { inherit pkgs; };
        modules = [
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                noobuser = import (../. + "/users/noobuser@home-server");
              };
            };
          }
          ./home-server/configuration.nix
        ];
      });
  };
}

