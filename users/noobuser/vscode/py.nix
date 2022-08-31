{ pkgs, ... }:
{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      matklad.rust-analyzer
      serayuzgur.crates
    ];
    userSettings = {
      "python.languageServer" = "Jedi";
      "python.linting.flake8Enabled" = true;
      "python.linting.mypyEnabled" = true;
      "python.linting.pydocstyleEnabled" = true;
      "python.linting.pylintEnabled" = false;
    };
  };
}
