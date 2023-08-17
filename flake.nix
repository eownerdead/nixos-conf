{
  description = "My System Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    unstable.url = "nixpkgs/nixos-unstable";
    parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:Mic92/nix-index-database";
  };

  outputs = inputs@{ self, parts, ... }:
    parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./hosts ];
      systems = [ "x86_64-linux" ];

      perSystem = { config, pkgs, system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            inputs.nur.overlay
            (self: super: {
              unstable = import inputs.unstable { inherit system; };
              my = import ./pkgs { pkgs = super; };
            })
          ];
          config.allowUnfreePredicate = pkg:
            builtins.elem (inputs.nixpkgs.lib.getName pkg) [
              "nvidia-x11"
              "nvidia-settings"
            ];
        };

        formatter = pkgs.nixpkgs-fmt;

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nixpkgs-fmt
            editorconfig-checker
            statix
            nix-init
            nurl
            sops
          ];
        };
      };

      flake = {
        nixosModules.default = import ./nixos;

        templates.default = {
          description = "Default Generic Template";
          path = ./templates/default;
        };
      };
    };
}

