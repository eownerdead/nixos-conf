{ fetchFromGitHub }:
let
  pname = "firefox-gnome-theme";
  version = "v108";
in
fetchFromGitHub {
  name = "${pname}-${version}";

  owner = "rafaelmardojai";
  repo = pname;
  rev = version;
  hash = "sha256-USZ1NgG14QMBcQZip2tkf63IOhhyWvwWkuKDOZOWMJA=";
}
