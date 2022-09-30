{ lib, pkgs, ... }:
{
  imports = [
    ../noobuser/cli.nix
    ../noobuser/git.nix
    ../noobuser/fish.nix

    ../noobuser/dev/nix.nix
  ];

  home = {
    username = "noobuser";
    homeDirectory = "/home/noobuser";
    stateVersion = "21.11";
  };
}
