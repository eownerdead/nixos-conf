{ pkgs, ... }:
let
  arkenfox_version = "106.0";
  arkenfox = builtins.readFile (pkgs.fetchurl {
    url =
      "https://raw.githubusercontent.com/arkenfox/user.js/${arkenfox_version}/user.js";
    hash = "sha256-KTNODuDsjgqbUtIWS9hCIDGG8WhsIRCc/CLI3BjxhMc=";
  });

  gnome-theme-userjs =
    builtins.readFile "${pkgs.my.firefox-gnome-theme}/configuration/user.js";
in
{
  # https://discourse.nixos.org/t/anyone-using-firefox-gnome-theme-successfully-with-nixos-home-manager/19248

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles.default = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        violentmonkey
        libredirect
      ];
      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
      '';
      userContent = ''
        @import "firefox-gnome-theme/userContent.css";
      '';
      settings = {
        "gnomeTheme.hideSingleTab" = true;
        "gnomeTheme.dragWindowHeaderbarButtons" = true;
        # https://github.com/rafaelmardojai/firefox-gnome-theme/issues/442
        "browser.tabs.tabmanager.enabled" = false;
        "intl.locale.requested" = "ja,en-US";
      };
      extraConfig =
        arkenfox + gnome-theme-userjs + builtins.readFile ./user-overrides.js;
    };
  };

  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
    source = pkgs.my.firefox-gnome-theme;
  };
}
