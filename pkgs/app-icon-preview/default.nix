{ stdenv
, fetchFromGitLab
, meson
, ninja
, pkg-config
, python3
, desktop-file-utils
, wrapGAppsHook
, rustPlatform
, libadwaita
, libxml2
}:
stdenv.mkDerivation rec {
  pname = "app-icon-preview";
  version = "3.1.0";

  src = fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "World/design";
    repo = "app-icon-preview";
    rev = version;
    hash = "sha256-3rTgMiHOiPUn25T2Otsqqe5wPE/dF9Skyn8JsF2Vu9Q=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-2FTu44EXbJPmzBGVB9DNDkvoQdcf0nyE3+wz+Pn2Z0s=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    python3
    desktop-file-utils
    libxml2.dev
    wrapGAppsHook
  ] ++ (with rustPlatform; [
    cargoSetupHook
    rust.cargo
    rust.rustc
  ]);

  buildInputs = [ libadwaita ];

  postPatch = ''
    patchShebangs build-aux/meson_post_install.py
  '';
}
