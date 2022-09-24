{ nixpkgs, ... }:
{
  # https://discourse.nixos.org/t/local-flake-based-nix-search-nix-run-and-nix-shell
  nix = {
    registry.nixpkgs.flake = nixpkgs;
    nixPath = [ "nixpkgs=${nixpkgs}" ];
  };
}
