{ pkgs }:
with pkgs; {
  eglot-tempel = callPackage ./eglot-tempel {
    inherit (pkgs.emacs.pkgs) trivialBuild eglot tempel;
  };
}
