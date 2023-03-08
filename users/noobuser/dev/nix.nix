{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];

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
}
