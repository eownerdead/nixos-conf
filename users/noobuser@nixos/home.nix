{ lib, pkgs, ... }:
{
  imports = [
    ../noobuser/nix-tools.nix
    ../noobuser/vscode.nix
    ../noobuser/firefox.nix
    ../noobuser/nushell.nix
    ../noobuser/gnome.nix
  ];

  home = {
    username = "noobuser";
    homeDirectory = "/home/noobuser";
    stateVersion = "21.11";

    packages = with pkgs; [
      android-tools
      wireshark
      inkscape
      # sourcetrail
      cargo
      cargo-asm
      cargo-edit
      cargo-sort
      cargo-generate
      rustc
      rustfmt
      clippy
      rust-analyzer
      crate2nix
      thunderbird-wayland
      drawing
      pkgconfig
      # error: collision between `/nix/store/xxx-gcc-wrapper-10.3.0/bin/ld' and
      # `/nix/store/xxx-clang-wrapper-11.1.0/bin/ld'
      # clang
      gcc
      gnome-usage
      my.adw-gtk3

      tutanota-desktop
      nemiver
      python3Packages.jedi-language-server
      icon-library
      gitg
      gtranslator
      fortune
      file
      cheat
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      mold
      blueprint-compiler
      tor-browser-bundle-bin
      binutils
      digikam
      my.system-monitoring-center
      my.dialect
      my.morisawa-biz-ud-gothic
      my.morisawa-biz-ud-mincho
      my.translate-locally-bin
    ] ++ (with pkgs.gnome; [
      gnome-todo
      ghex
    ]);
  };

  programs = {
    bash = {
      enable = true;
      initExtra = ''
        fortune
        echo

        [ -v $USE_BASH ] && exec nu
      '';
    };
    bat.enable = true;
    exa = {
      enable = true;
      enableAliases = true;
    };
    chromium = {
      enable = true;
    };
    git = {
      enable = true;
      delta.enable = true;
      userEmail = "you@example.com";
      userName = "Your Name";
    };
    home-manager.enable = true;
  };
}
