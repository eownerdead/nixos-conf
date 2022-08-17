{ lib, hobbits, python39, python39Packages }:
(hobbits.override {
  python3 = python39;
})
