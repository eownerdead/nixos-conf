{ python3
, fetchgit
, meson
, ninja
, gobject-introspection
, desktop-file-utils
, wrapGAppsHook
, pkg-config
, libadwaita
, libsoup_3
}:
python3.pkgs.buildPythonApplication rec {
  pname = "dialect";
  version = "main";

  format = "other";

  src = fetchgit {
    url = "https://github.com/dialect-app/${pname}/";
    rev = "293a0d8135f0ba076121b9974951041b93adb9c2";
    sha256 = "sha256-0O+L0DygSpytmQCrarTQoxNVyi4UonyTMZke2+F21EI=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wrapGAppsHook
    gobject-introspection
    desktop-file-utils
  ];

  buildInputs = [
    libadwaita
    libsoup_3
  ];

  propagatedBuildInputs = with python3.pkgs; [
    pygobject3
    googletrans
    gtts
    dbus-python
    gst-python
  ];

  dontWrapGApps = true;

  postPatch = ''
    patchShebangs build-aux/meson/postinstall.py
  '';

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  strictDeps = false;
}
