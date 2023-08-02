{ pkgs, ... }:
with pkgs; {
  morisawa-biz-ud-gothic = callPackage ./morisawa-biz-ud-gothic { };
  morisawa-biz-ud-mincho = callPackage ./morisawa-biz-ud-mincho { };
  translate-locally-bin = callPackage ./translate-locally-bin { };
  firefox-gnome-theme = callPackage ./firefox-gnome-theme { };
  emacsPackages = import ./elisp-packages {
    inherit pkgs;
  };
}
