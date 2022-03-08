{ config, lib, pkgs, ... }: {
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
    firefox-wayland
    thunderbird-wayland
    drawing
    chromium
    pkgconfig
    # error: collision between `/nix/store/xxx-gcc-wrapper-10.3.0/bin/ld' and
    # `/nix/store/xxx-clang-wrapper-11.1.0/bin/ld'
    # clang
    gcc
    git
    nixpkgs-fmt
    gnome-usage
    my.adw-gtk3

    tutanota-desktop
    nemiver
    gnome.gnome-todo
    python3Packages.jedi-language-server
    icon-library
    gnome.networkmanager-l2tp
    gitg
    my.gittyup
    my.blueprint-compiler
  ] ++ (with pkgs.gnomeExtensions; [
    dash-to-dock
    fuzzy-app-search
    alphabetical-app-grid
  ]);

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple [ "ibus" "mozc-jp" ])
        (lib.hm.gvariant.mkTuple [ "xkb" "jp" ])
      ];
    };

    "org/gnome/shell" = {
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com"
        "AlphabeticalAppGrid@stuarthayhurst"
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
      gtk-theme = "adw-gtk3";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
