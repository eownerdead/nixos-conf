{ python3
, fetchFromGitHub
, meson
, ninja
, gobject-introspection
, desktop-file-utils
, wrapGAppsHook
, pkg-config
, libadwaita
, libsoup_3
, blueprint-compiler
}:
python3.pkgs.buildPythonApplication rec {
  pname = "dialect";
  version = "2.0.2";

  format = "other";

  src = fetchFromGitHub {
    owner = "dialect-app";
    repo = "${pname}";
    rev = version;
    fetchSubmodules = true;
    sha256 = "sha256-55vqxS0ySV8lItxLl1J+wLvPtmR87HzGfAiOKuhigFA=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wrapGAppsHook
    gobject-introspection
    desktop-file-utils
    blueprint-compiler
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
