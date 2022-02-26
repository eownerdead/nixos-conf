{ lib, stdenv, fetchFromGitHub, meson, ninja, sassc }:
stdenv.mkDerivation rec {
    name = "adw-gtk3";
    version = "v1.2";

    src = fetchFromGitHub {
        owner = "lassekongo83";
        repo = "adw-gtk3";
        rev = version;
        sha256 = "sha256-6g3iMF7vfotYetuyfAJKRLoBUKPYpIs/H3rx5hNH5pc=";
    };

    nativeBuildInputs = [ meson ninja sassc ];
}
