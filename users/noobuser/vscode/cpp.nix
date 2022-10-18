{ pkgs, ... }:
{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      llvm-vs-code-extensions.vscode-clangd
      vadimcn.vscode-lldb
    ];
    userSettings = {
      "clangd.arguments" = [
        "-fallback-style=\"{DisableFormat =true}\""
        "-clang-tidy"
        "-pch-storage=memory"
        "-cross-file-rename"
        "-completion-parse=auto"
        "-log=info"
        "-enable-config"
      ];
    };
  };
}
