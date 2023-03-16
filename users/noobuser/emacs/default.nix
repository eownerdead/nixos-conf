{ pkgs, lib, ... }:
let
  fromUsePackage =
    epkgs: initEl: [ epkgs.use-package ] ++ map (name: epkgs.${name})
      (builtins.fromJSON (builtins.readFile (pkgs.runCommand "from-use-package"
        {
          nativeBuildInputs = with pkgs; [
            (emacs-gtk.pkgs.emacsWithPackages (epkgs: [ epkgs.use-package ]))
          ];
        }
        "emacs --script ${./use-package-list.el} ${initEl} > $out || true")));

  allGrammars =
    p: builtins.filter pkgs.lib.attrsets.isDerivation (builtins.attrValues p);
in
{
  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraConfig = builtins.readFile ./init.el;
    extraPackages = epkgs: (fromUsePackage epkgs ./init.el) ++ (with epkgs; [
      (tree-sitter-langs.withPlugins allGrammars)
      pkgs.my.emacsPackages.eglot-tempel
      epkgs.llvm-mode
    ]);
  };
}
