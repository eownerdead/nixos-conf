{ pkgs, ... }:
{
  programs = {
    fish = {
      enable = true;
      shellAliases = {
        sudo = "doas";
      };
      functions = {
        bash = "USE_BASH=1 ${pkgs.bash}/bin/bash $argv";
        bash-run = ''bash -c "$argv"'';
      };
      shellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
    };

    zoxide.enableFishIntegration = true;
  };
}
