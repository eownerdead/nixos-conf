{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    delta.enable = true;
    userEmail = "you@example.com";
    userName = "Your Name";
    aliases = {
      oneline = "log --oneline";
      last = "log -1 HEAD";
      unstage = "reset HEAD";
      shallow = "clone --depth 1";
      alias = "!git config --get-regexp ^alias.";
      c = "commit -v";
      ca = "commit -av";
      co = "checkout";
      br = "branch";
      st = "status";
      ll = "log --oneline";
    };
  };
}
