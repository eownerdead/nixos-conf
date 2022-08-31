{ pkgs, ... }:
{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      matklad.rust-analyzer
      serayuzgur.crates
    ];
    userSettings = {
      "rust-analyzer.checkOnSave.command" = "clippy";
      "rust-analyzer.experimental.procAttrMacros" = true;
      "rust-analyzer.inlayHints.enable" = false;
      "rust-analyzer.updates.askBeforeDownload" = true;
    };
  };
}
