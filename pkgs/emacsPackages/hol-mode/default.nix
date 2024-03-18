{ trivialBuild, hol }:
trivialBuild {
  inherit (hol) src;
  pname = "hol-mode";
  version = "14";

  postUnpack = ''
    cp ./src/hol-kananaskis-14/tools/*.el ./
  '';
}
