{ lib, ibus-engines, fetchzip }:
ibus-engines.mozc.overrideAttrs (oldAttrs: rec {
  pname = "ibus-mozc-ut";

  mozcdic-ut = fetchzip {
    url = "https://osdn.net/downloads/users/39/39056/mozcdic-ut-20220904.tar.bz2";
    hash = "sha256-R5lsKezPsWQoydkt4PfwAP09I/x0v4uzCdOe5SCD/Eo=";
  };

  postPatch = ''
    cat ${mozcdic-ut}/mozcdic*-ut-*.txt >> \
      ./src/data/dictionary_oss/dictionary00.txt
  '';
})
