{ pkgs, ... }:
{
  home.packages = with pkgs; [
    python3
  ] ++ (with python3Packages; [
    ptpython
  ]);
}
