pushd ~/.dotfiles
nix build .#homeManagerConfigurations.noobuser.activationPackage
./result/activate
popd
