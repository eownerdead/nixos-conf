{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cargo
    cargo-asm
    cargo-edit
    cargo-sort
    cargo-generate
    rustc
    rustfmt
    clippy
    rust-analyzer
    crate2nix
  ];
}
