{ pkgs, ... }:
{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      haskell.haskell
    ];
    userSettings = { };
  };
}
