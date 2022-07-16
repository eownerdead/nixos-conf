{ lib, pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    dash-to-dock
    fuzzy-app-search
    alphabetical-app-grid
    tiling-assistant
    customize-ibus
  ];

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
}
