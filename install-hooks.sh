#!/bin/bash
# Install git hooks into the yadm repository.
#
# yadm keeps its git directory outside the worktree, so the hooks path has to
# be asked for rather than assumed to be ./.git/hooks.

set -euo pipefail

if ! command -v yadm >/dev/null 2>&1; then
    echo "yadm is not installed."
    exit 1
fi

HOOKS_DIR="$(yadm rev-parse --git-dir)/hooks"
SRC_DIR="$HOME/.github/hooks"

mkdir -p "$HOOKS_DIR"

if [ ! -x "$HOME/.local/bin/trufflehog" ] && ! command -v trufflehog >/dev/null 2>&1; then
    echo "WARNING: trufflehog not found. The hook will skip scanning until it is installed:"
    echo "  curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sh -s -- -b ~/.local/bin"
fi

for src in "$SRC_DIR"/*; do
    [ -f "$src" ] || continue
    name=$(basename "$src")
    install -m 755 "$src" "$HOOKS_DIR/$name"
    echo "Installed: $name -> $HOOKS_DIR/$name"
done

echo "Done."
