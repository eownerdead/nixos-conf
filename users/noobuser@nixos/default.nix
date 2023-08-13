{ lib, pkgs, inputs, ... }:
{
  imports = [
    ../noobuser/cli.nix
    ../noobuser/git.nix
    ../noobuser/gpg.nix
    ../noobuser/firefox
    ../noobuser/fish.nix
    ../noobuser/emacs

    ../noobuser/vscode
    ../noobuser/dev/nix.nix
    ../noobuser/vscode/nix.nix
    ../noobuser/dev/py.nix
    ../noobuser/vscode/py.nix
    ../noobuser/dev/cpp.nix
    ../noobuser/vscode/cpp.nix
    ../noobuser/dev/rs.nix
    ../noobuser/vscode/rs.nix
    ../noobuser/dev/hs.nix
    ../noobuser/vscode/hs.nix
  ];

  home = {
    username = "noobuser";
    homeDirectory = "/home/noobuser";
    stateVersion = "21.11";

    packages = with pkgs; [
      dconf
      android-tools
      wireshark
      inkscape

      jetbrains-mono
      mold
      blueprint-compiler
      tor-browser-bundle-bin
      digikam
      virt-manager
      libreoffice
      darktable
      hdrmerge
      hugin
      my.morisawa-biz-ud-gothic
      my.morisawa-biz-ud-mincho
      my.translate-locally-bin
      coq
      gnumake
      (isabelle.withComponents (p: [ p.isabelle-linter ]))
    ];
  };

  programs = {
    chromium = {
      enable = true;
    };
    home-manager.enable = true;
  };
}

