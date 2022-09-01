{ pkgs, ... }:
{
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
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
