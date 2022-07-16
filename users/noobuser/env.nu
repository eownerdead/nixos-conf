alias bash = USE_BASH=1 bash

def bash-run [...cmd: string] {
    bash -c ($cmd | str collect " ")
}

alias tree = exa -T --icons
