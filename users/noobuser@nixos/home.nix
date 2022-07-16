{ lib, pkgs, ... }:
{
  imports = [
    ../noobuser/vscode.nix
    ../noobuser/firefox.nix
    ../noobuser/nushell.nix
  ];

  home = {
    username = "noobuser";
    homeDirectory = "/home/noobuser";
    stateVersion = "21.11";

    packages = with pkgs; [
      android-tools
      wireshark
      inkscape
      rnix-lsp
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
      nixpkgs-fmt
      statix
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
      comma
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      mold
      blueprint-compiler
      cached-nix-shell
      nix-output-monitor
      tor-browser-bundle-bin
      hydra-check
      my.system-monitoring-center
      my.dialect
      my.morisawa-biz-ud-gothic
      my.morisawa-biz-ud-mincho
      my.translate-locally-bin
    ] ++ (with pkgs.gnome; [
      gnome-todo
      ghex
    ]) ++ (with pkgs.gnomeExtensions; [
      dash-to-dock
      fuzzy-app-search
      alphabetical-app-grid
      tiling-assistant
      customize-ibus
    ]);
  };

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple [ "ibus" "mozc-jp" ])
        (lib.hm.gvariant.mkTuple [ "xkb" "jp" ])
      ];
    };
    "org/gnome/shell" = {
      disable-extension-version-validation = true;
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com"
        "AlphabeticalAppGrid@stuarthayhurst"
        "tiling-assistant@leleat-on-github"
        "customize-ibus@hollowman.ml"
      ];
    };
    # Ubuntu-like dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "LEFT";
      dock-fixed = true;
      custom-theme-shrink = true;
      extend-height = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };
    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
    };
  };

  gtk = {
    font.name = "Noto Sans CJK JP";
    theme.name = "adw-gtk3";
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
    nix-index = {
      enable = true;
      enableBashIntegration = true;
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
