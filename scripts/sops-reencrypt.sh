#!/usr/bin/env bash
set -euo pipefail

usage() {
    echo "Usage: $0 <secrets.yaml>"
    echo
    echo "Decrypts a sops-encrypted secrets.yaml and re-encrypts it in-place."
    echo "Useful when new plaintext keys have been added to an already-encrypted file."
    exit 1
}

[[ $# -ne 1 ]] && usage

FILE="$1"

[[ ! -f "$FILE" ]] && { echo "Error: file not found: $FILE"; exit 1; }

command -v sops &>/dev/null || { echo "Error: sops not found in PATH"; exit 1; }

TMPFILE=$(mktemp)
trap 'rm -f "$TMPFILE"' EXIT

echo "Decrypting $FILE..."
sops decrypt "$FILE" > "$TMPFILE"

echo "Re-encrypting $FILE..."
cp "$TMPFILE" "$FILE"
sops encrypt --in-place "$FILE"

echo "Done."
