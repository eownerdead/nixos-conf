{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rnix-lsp
    nixpkgs-fmt
    statix
    hydra-check
    cached-nix-shell
    nix-output-monitor
    comma
    nix-tree
  ];

  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
  };

  home.file."nix-index-database" = {
    target = ".cache/nix-index/files";
    source = pkgs.database;
  };
}
