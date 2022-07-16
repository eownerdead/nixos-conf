{ pkgs, ... }:
with pkgs; {
  adw-gtk3 = callPackage ./adw-gtk3/default.nix { };
  system-monitoring-center =
    callPackage ./system-monitoring-center/default.nix { };
  dialect = callPackage ./dialect/default.nix { };
  ibus-mozc-ut = callPackage ./ibus-mozc-ut/default.nix { };
  morisawa-biz-ud-gothic = callPackage ./morisawa-biz-ud-gothic { };
  morisawa-biz-ud-mincho = callPackage ./morisawa-biz-ud-mincho { };
  translate-locally-bin = callPackage ./translate-locally-bin { };
  firefox-gnome-theme = callPackage ./firefox-gnome-theme { };
}
