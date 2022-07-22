{ lib, pkgs, ... }:
{
  imports = [
    ../noobuser/nix-tools.nix
    ../noobuser/vscode.nix
    ../noobuser/firefox.nix
    ../noobuser/nushell.nix
    ../noobuser/gnome.nix

    ../noobuser/dev/cpp.nix
    ../noobuser/dev/rust.nix
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
      thunderbird-wayland
      drawing
      pkgconfig
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
      digikam
      virt-manager
      fragments
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
