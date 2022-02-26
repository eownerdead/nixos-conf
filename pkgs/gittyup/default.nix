{ pkgs, stdenv, fetchgit, cmake, pkg-config, libsForQt5, desktop-file-utils }:
let
  inherit (libsForQt5) qtbase qttools wrapQtAppsHook;
in
stdenv.mkDerivation {
  name = "gittyup";

  src = fetchgit {
    url = https://github.com/Murmele/Gittyup.git;
    rev = "d52896fa79c596bed4d662633f48c507496c9fd6";
    hash = "sha256-jceBP3uXeM1Qtm5BbD0ZoqrCHAkqU3OM8isL8p4GosQ=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    qttools
    wrapQtAppsHook
    desktop-file-utils
  ];

  buildInputs = [ qtbase ];

  preConfigure = ''
    export cmakeFlags="-DCMAKE_INSTALL_PREFIX=$prefix/lib/gittyup $cmakeFlags"
  '';

  # https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=gittyup-git
  postInstall = ''
    wrapQtApp $out/lib/gittyup/Gittyup

    rm $out/lib/gittyup/*.so.*

    mkdir $out/bin
    ln -s $out/lib/gittyup/Gittyup $out/bin/gittyup

    desktop-file-install --dir=$out/share/applications \
      --set-key=Exec --set-value=$out/bin/gittyup \
      ../rsrc/linux/com.github.Murmele.Gittyup.desktop

    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp ../rsrc/Gittyup.iconset/gittyup_logo.svg \
      $out/share/icons/hicolor/scalable/apps/gittyup.svg
    for s in 16x16 32x32 64x64 128x128 256x256 512x512; do
      mkdir -p $out/share/icons/hicolor/$s/apps
      cp ../rsrc/Gittyup.iconset/icon_$s.png \
        $out/share/icons/hicolor/$s/apps/gittyup.png
    done

    mkdir $out/lib/gittyup/Resources/l10n
    mv ./l10n/*.qm $out/lib/gittyup/Resources/l10n

    rm -r $out/lib/gittyup/Plugins
  '';
}
