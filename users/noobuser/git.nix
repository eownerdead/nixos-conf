{ pkgs, ... }:
let
  gitAlias =  pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/GitAlias/gitalias/ed036c1fd16c8e690329c594bc028f58c6e3b349/gitalias.txt";
    hash = "sha256-tcZNjDClFz6Auj+cdWVQxXL5zg+fvIbaz02C/acbBs4=";
  };
in
{
  programs.git = {
    enable = true;
    delta.enable = true;
    userEmail = "you@example.com";
    userName = "Your Name";
    extraConfig = {
      include.path = "${gitAlias}";
      commit.verbose = true;
      credential.helper = [
        "cache"
        "${pkgs.unstable.git-credential-oauth}/bin/git-credential-oauth"
      ];
    };
  };
}
