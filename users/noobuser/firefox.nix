{ pkgs, ... }:
{
  # https://discourse.nixos.org/t/anyone-using-firefox-gnome-theme-successfully-with-nixos-home-manager/19248

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles.default = {
      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
      '';
      userContent = ''
        @import "firefox-gnome-theme/userContent.css";
      '';
      settings = {
        "gnomeTheme.hideSingleTab" = true;
        "gnomeTheme.dragWindowHeaderbarButtons" = true;
      };
      extraConfig = builtins.readFile
        "${pkgs.my.firefox-gnome-theme}/configuration/user.js";
    };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      localcdn
      violentmonkey
    ];
  };

  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
    source = pkgs.my.firefox-gnome-theme;
  };
}
