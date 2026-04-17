#!/usr/bin/env sh
set -eu

RAW_BASE_URL="https://raw.githubusercontent.com/zhanglongx/git-all/main"
TARGET="/usr/local/bin/git-all"
TMP_FILE="$(mktemp)"

cleanup() {
    rm -f "$TMP_FILE"
}

trap cleanup EXIT INT TERM

download() {
    url="$1"
    output="$2"

    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$url" -o "$output"
        return
    fi

    if command -v wget >/dev/null 2>&1; then
        wget -qO "$output" "$url"
        return
    fi

    echo "install.sh: curl or wget is required" >&2
    exit 1
}

install_binary() {
    source_path="$1"
    target_path="$2"

    if [ -w "$(dirname "$target_path")" ]; then
        install -m 755 "$source_path" "$target_path"
        return
    fi

    if command -v sudo >/dev/null 2>&1; then
        sudo install -m 755 "$source_path" "$target_path"
        return
    fi

    echo "install.sh: write permission to $(dirname "$target_path") is required" >&2
    exit 1
}

download "$RAW_BASE_URL/git-all" "$TMP_FILE"
install_binary "$TMP_FILE" "$TARGET"

echo "Installed git-all to $TARGET"
