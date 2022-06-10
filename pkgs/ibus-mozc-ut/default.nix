{ lib, ibus-engines, fetchzip }:
ibus-engines.mozc.overrideAttrs (oldAttrs: rec {
  pname = "ibus-mozc-ut";
  dictdate = "20220525";

  mozcdic-ut = fetchzip {
    url = "https://osdn.net/downloads/users/38/38446/mozcdic-ut-${dictdate}.tar.bz2";
    hash = "sha256-cOoVniVz3i6LnVACYKEFuyPY/G4YzdCdbY69gj3noaQ=";
  };

  postPatch = ''
    cat ${mozcdic-ut}/mozcdic*-ut-*.txt >> \
      ./src/data/dictionary_oss/dictionary00.txt
  '';
})
