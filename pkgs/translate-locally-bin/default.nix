{ lib, stdenv, dpkg, libsForQt5, fetchurl, libarchive, qt5 }:
stdenv.mkDerivation rec {
  name = "translate-locally-bin";
  version = "0.0.2+136745e";

  src = fetchurl {
    url = "https://github.com/XapaJIaMnu/translateLocally/releases/download/latest/translateLocally-v${version}-Ubuntu-20.04.AVX.deb";
    sha256 = "sha256-8UJyQKsEnvzGnoLuJp0hYnQ0Z1oNvgH+MMI4/z0N6+8=";
  };

  nativeBuildInputs = [
    dpkg
    libsForQt5.wrapQtAppsHook
  ];

  sourceRoot = ".";

  unpackCmd = "dpkg-deb -x ${src} .";

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -r usr/* $out
    mkdir -p $out/share/icons/hicolor/scalable/apps/
    mv $out/share/icons/translateLocally_logo.svg \
      $out/share/icons/hicolor/scalable/apps/
  '';

  preFixup =
    let
      libPath = lib.makeLibraryPath [
        libarchive
        qt5.qtbase
        qt5.qtsvg
        stdenv.cc.cc.lib
      ];
    in
    ''
      patchelf \
        --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        --set-rpath "${libPath}" \
        $out/bin/translateLocally
    '';
}
