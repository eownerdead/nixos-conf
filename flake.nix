{
  description = "My System Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
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
      };

      flake = {
        templates.default = { path = ./templates/default; };
      };
    };
}

