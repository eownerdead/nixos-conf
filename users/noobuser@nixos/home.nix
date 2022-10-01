{ lib, pkgs, ... }:
{
  imports = [
    ../noobuser/cli.nix
    ../noobuser/git.nix
    ../noobuser/firefox.nix
    ../noobuser/nushell.nix
    ../noobuser/fish.nix
    ../noobuser/gnome.nix

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
      android-tools
      wireshark
      inkscape
      # sourcetrail
      thunderbird-wayland
      drawing
      gnome-usage
      my.adw-gtk3

      tutanota-desktop
      nemiver
      icon-library
      gitg
      gtranslator
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      mold
      blueprint-compiler
      tor-browser-bundle-bin
      digikam
      virt-manager
      fragments
      libreoffice
      libsForQt5.qtstyleplugin-kvantum
      googleearth-pro
      bochs
      geany
      gnome-builder
      my.system-monitoring-center
      my.dialect
      my.morisawa-biz-ud-gothic
      my.morisawa-biz-ud-mincho
      my.translate-locally-bin
      my.textadept-gtk3
      my.hobbits
    ] ++ (with pkgs.gnome; [
      gnome-todo
      ghex
    ]);
  };

  programs = {
    chromium = {
      enable = true;
    };
    home-manager.enable = true;
  };
}
