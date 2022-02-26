{ pkgs, ... }:
with pkgs; {
  gittyup = (callPackage ./gittyup/default.nix { });
  adw-gtk3 = (callPackage ./adw-gtk3/default.nix { });
}
