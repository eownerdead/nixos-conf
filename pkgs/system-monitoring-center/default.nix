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
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "hakandundar34coding";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-iiGYMc0FdbmYLwkcrQBNkPn/BmSmL/a2/S9Rvp8GSMs=";
  };

  buildInputs = [
    bash
    dmidecode
    gtk3
    hwdata
    iproute2
    glxinfo
    systemd
    util-linux
  ];

  propagatedBuildInputs = with python3.pkgs; [
    pycairo
    pygobject3
    wrapGAppsHook
  ];

  dontWrapGApps = true;

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  postInstall = ''
    mv "$out/${python3.sitePackages}/usr/share" $out
    rm -r "$out/lib"

    substituteInPlace $out/bin/system-monitoring-center \
      --replace "/usr/share/system-monitoring-center/src/" \
      "$out/share/system-monitoring-center/src/"
  '';
}
