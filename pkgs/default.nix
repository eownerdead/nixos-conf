{ pkgs, ... }:
with pkgs; {
  gittyup = (callPackage ./gittyup/default.nix { });
  adw-gtk3 = (callPackage ./adw-gtk3/default.nix { });
  blueprint-compiler = (callPackage ./blueprint-compiler/default.nix { });
}
