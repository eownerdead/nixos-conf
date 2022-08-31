{ pkgs, ... }:
{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      arrterian.nix-env-selector
    ];
    userSettings = {
      "nix.enableLanguageServer" = true;
    };
  };
}
