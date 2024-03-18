{ lib, pkgs, inputs, ... }: {
  imports = [
    ../noobuser/cli.nix
    ../noobuser/git.nix
    ../noobuser/mercurial.nix
    ../noobuser/gpg.nix
    ../noobuser/pass.nix
    ../noobuser/firefox.nix
    ../noobuser/emacs

    ../noobuser/dev/nix.nix
    ../noobuser/dev/py.nix
    ../noobuser/dev/web.nix
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
      agda
      (isabelle.withComponents (p: [ p.isabelle-linter ]))
      hol
      anki
      tigervnc
      nyx
      wayfire
    ];
  };

  programs = {
    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      # https://github.com/NixOS/nixpkgs/issues/158449
      extensions = [{
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; # uBlock Origin
      }];
    };
    home-manager.enable = true;
  };
}

