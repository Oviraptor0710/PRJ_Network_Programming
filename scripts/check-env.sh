#!/usr/bin/env bash
set -u

missing=0

check_command() {
    if command -v "$1" >/dev/null 2>&1; then
        printf 'OK      %s\n' "$1"
    else
        printf 'MISSING %s\n' "$1"
        missing=1
    fi
}

check_header() {
    if printf '#include <%s>\nint main(void) { return 0; }\n' "$1" |
        gcc -x c - -fsyntax-only >/dev/null 2>&1; then
        printf 'OK      <%s>\n' "$1"
    else
        printf 'MISSING <%s>\n' "$1"
        missing=1
    fi
}

if [[ "$(uname -s)" != Linux ]]; then
    printf 'Run this check inside Ubuntu/WSL.\n' >&2
    exit 1
fi

check_command gcc
check_command make
check_command gdb
check_command pkg-config
check_command openssl
if command -v sqlite3 >/dev/null 2>&1; then
    printf 'OK      sqlite3 (optional CLI)\n'
else
    printf 'OPTIONAL sqlite3 CLI is not installed\n'
fi

if command -v gcc >/dev/null 2>&1; then
    check_header sys/socket.h
    check_header openssl/ssl.h
    check_header sqlite3.h
fi

if (( missing != 0 )); then
    printf '\nEnvironment is incomplete. See README.md.\n' >&2
    exit 1
fi

printf '\nEnvironment is ready for C development.\n'
