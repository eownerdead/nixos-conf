{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      usernamehw.errorlens
      mhutchie.git-graph
      tamasfe.even-better-toml
      codezombiech.gitignore
      eamodio.gitlens
      oderwat.indent-rainbow
      pkief.material-icon-theme
      pkief.material-product-icons
      ibm.output-colorizer
      timonwong.shellcheck
      mads-hartmann.bash-ide-vscode
      editorconfig.editorconfig
      jnoortheen.nix-ide
      arrterian.nix-env-selector
      redhat.vscode-yaml
      jock.svg
      llvm-vs-code-extensions.vscode-clangd
      matklad.rust-analyzer
      serayuzgur.crates
      ms-python.python
    ];
    userSettings = import ./vscode-settings.nix;
  };
}
