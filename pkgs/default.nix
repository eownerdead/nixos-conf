{ pkgs, ... }:
with pkgs; {
  gittyup = callPackage ./gittyup/default.nix { };
}
