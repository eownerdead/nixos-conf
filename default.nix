# Packages for NUR
{ flake ? builtins.getFlake (toString ./.)
, pkgs ? flake.inputs.nixpkgs { } }:
flake.packages // {
  modules = flake.nixosModules.default;
  overlays = flake.overlays.default;
}
