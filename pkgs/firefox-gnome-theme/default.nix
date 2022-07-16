{ fetchFromGitHub }:
let
  pname = "firefox-gnome-theme";
  version = "v102";
in
fetchFromGitHub {
  name = "${pname}-${version}";

  owner = "rafaelmardojai";
  repo = pname;
  rev = version;
  hash = "sha256-LwHDZV688YVkddgWVUIk07FUeT0Z+E+mETWmOZ7U73k=";
}
