{ pkgs, ... }:
{
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
  };

  # Fix `error: executing 'git': No such file or directory`
  programs.git.enable = true;
}

