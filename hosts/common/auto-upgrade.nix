{ pkgs, ... }:
{
  system.autoUpgrade = {
    enable = true;
    flake = "/home/noobuser/.dotfiles";
    flags = [ "--recreate-lock-file" "--commit-lock-file" ];
  };

  programs.git = {
    enable = true;
    config = {
      user = {
        email = "you@example.com";
        name = "Your Name";
      };
    };
  };
}
