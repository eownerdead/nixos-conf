{ fetchFromGitLab, meson, ninja, python3 }:
python3.pkgs.buildPythonApplication {
  name = "blueprint-compiler";

  src = fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "jwestman";
    repo = "blueprint-compiler";
    rev = "8ea06e8a78ecd61726352d8665c2c97104854dab";
    hash = "sha256-EggcFD9CMj5N4o8j40Ukhi+nXd9m+kqELK5VMPEKLsU=";
  };

  format = "other";

  nativeBuildInputs = [
    meson
    ninja
  ];

  buildInputs = [ ];

  setupHook = ./setup-hook.sh;
}
