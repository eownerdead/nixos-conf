{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fortune
    file
    cheat
  ];

  programs = {
    bash = {
      enable = true;
      initExtra = ''
        fortune
        echo
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
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [ "--cmd" "cd" ];
    };
  };
}
