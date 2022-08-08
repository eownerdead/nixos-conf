{ lib, textadept, gtk3 }:
textadept.overrideAttrs (oldAttrs: rec {
  pname = oldAttrs.pname + "-gtk3";

  buildInputs =
    (builtins.filter (i: i.pname != "gtk+") oldAttrs.buildInputs) ++ [ gtk3 ];

  makeFlags = lib.lists.remove "GTK2=1" oldAttrs.makeFlags;
})
