{ lib, pkgs, inputs, ... }: {
  imports = [
    ../noobuser/cli.nix
    ../noobuser/git.nix
    ../noobuser/gpg.nix
    ../noobuser/firefox.nix
    ../noobuser/fish.nix
    ../noobuser/emacs

    ../noobuser/dev/nix.nix
    ../noobuser/dev/py.nix
    ../noobuser/dev/cpp.nix
    ../noobuser/dev/rs.nix
    ../noobuser/dev/hs.nix
  ];

  home = {
    username = "noobuser";
    homeDirectory = "/home/noobuser";
    stateVersion = "21.11";

    packages = with pkgs; [
      dconf
      android-tools
      wireshark
      gimp
      inkscape
      jetbrains-mono
      tor-browser-bundle-bin
      digikam
      virt-manager
      libreoffice
      darktable
      hdrmerge
      hugin
      my.morisawa-biz-ud-gothic
      my.morisawa-biz-ud-mincho
      coq
      (isabelle.withComponents (p: [ p.isabelle-linter ]))
      anki
      tigervnc
    ];
  };

  programs = {
    chromium = { enable = true; };
    home-manager.enable = true;
  };
}

