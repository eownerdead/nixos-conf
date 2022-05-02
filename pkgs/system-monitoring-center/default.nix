{ python3
, fetchFromGitHub
, gobject-introspection
, bash
, dmidecode
, gtk3
, hwdata
, iproute2
, glxinfo
, systemd
, util-linux
, wrapGAppsHook
}:
python3.pkgs.buildPythonApplication rec {
  pname = "system-monitoring-center";
  version = "1.13.0";

  src = fetchFromGitHub {
    owner = "hakandundar34coding";
    repo = pname;
    rev = "v${version}-deb_for_stores";
    sha256 = "sha256-7LfiNaj6VVYeK/1zMGwNscQojxgaP5HdglVgxZOwbSE=";
  };

  buildInputs = [
    gobject-introspection
    bash
    dmidecode
    gtk3
    hwdata
    iproute2
    glxinfo
    systemd
    util-linux
  ];

  nativeBuildInputs = [
    wrapGAppsHook
  ];

  propagatedBuildInputs = with python3.pkgs; [
    pycairo
    pygobject3
  ];

  dontWrapGApps = true;

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  postInstall = ''
    mv $out/${python3.sitePackages}/usr/{share,bin} $out
    rm -r "$out/lib"

    substituteInPlace $out/bin/system-monitoring-center \
      --replace "/usr/share/system-monitoring-center/src/" \
      "$out/share/system-monitoring-center/src/"

    substituteInPlace $out/share/system-monitoring-center/src/MainGUI.py \
      --replace '"/usr' "\"$out"
  '';

  strictDeps = false;
}
