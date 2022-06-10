{ pkgs, ... }:
with pkgs; {
  gittyup = (callPackage ./gittyup/default.nix { });
  adw-gtk3 = (callPackage ./adw-gtk3/default.nix { });
  system-monitoring-center =
    (callPackage ./system-monitoring-center/default.nix { });
  app-icon-preview = (callPackage ./app-icon-preview/default.nix { });
  dialect = (callPackage ./dialect/default.nix { });
  ibus-mozc-ut = (callPackage ./ibus-mozc-ut/default.nix { });
}
