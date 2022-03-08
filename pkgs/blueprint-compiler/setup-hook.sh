make_blueprint_compiler_find_gir_files() {
    # XDG_DATA_DIRS: required for finding .gir files
    if [ -d "$1/share/gir-1.0" ]; then
        addToSearchPath XDG_DATA_DIRS $1/share
    fi
}

addEnvHooks "$hostOffset" make_blueprint_compiler_find_gir_files

_multioutMoveGlibGir() {
    moveToOutput share/gir-1.0 "${!outputDev}"
}

preFixupHooks+=(_multioutMoveGlibGir)
