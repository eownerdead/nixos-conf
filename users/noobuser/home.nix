{ config, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "noobuser";
  home.homeDirectory = "/home/noobuser";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "21.11";

  home.packages = with pkgs; [
    android-tools
    jetbrains-mono
    wireshark
    vscodium
    inkscape
    rnix-lsp
    sourcetrail
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

    tutanota-desktop
    nemiver
    gnome.gnome-todo
    python3Packages.jedi-language-server
    icon-library
    gnome.networkmanager-l2tp
    gitg
    my.gittyup
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
