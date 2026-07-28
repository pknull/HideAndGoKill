#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION="${1:-1.21.8}"
MC_HOME="${MC_HOME:-$HOME/.minecraft}"
VERSION_DIR="$MC_HOME/versions/$VERSION"
VERSION_JAR="$VERSION_DIR/$VERSION.jar"
VERSION_JSON="$VERSION_DIR/$VERSION.json"
LIBRARY_DIR="$MC_HOME/libraries"
JAVA_BIN="${JAVA_BIN:-$MC_HOME/runtime/java-runtime-delta/linux/java-runtime-delta/bin/java}"

for path in "$VERSION_JAR" "$VERSION_JSON" "$JAVA_BIN"; do
    if [[ ! -e "$path" ]]; then
        echo "Missing required Minecraft test dependency: $path" >&2
        exit 2
    fi
done

command -v jq >/dev/null || {
    echo "jq is required to construct the Minecraft classpath." >&2
    exit 2
}

classpath="$VERSION_JAR"
while IFS= read -r library; do
    if [[ -f "$LIBRARY_DIR/$library" ]]; then
        classpath="$classpath:$LIBRARY_DIR/$library"
    fi
done < <(jq -r '.libraries[].downloads.artifact.path // empty' "$VERSION_JSON")

workdir="$(mktemp -d "${TMPDIR:-/tmp}/hagk-gametest.XXXXXX")"
trap 'rm -rf "$workdir"' EXIT
mkdir -p "$workdir/packs"
ln -s "$ROOT" "$workdir/packs/HideAndGoKill"

log="$workdir/gametest.log"
(
    cd "$workdir"
    "$JAVA_BIN" -cp "$classpath" net.minecraft.gametest.Main \
        --packs "$workdir/packs" \
        --universe "$workdir/world" \
        --report "$workdir/report.xml" \
        --tests ""
) 2>&1 | tee "$log"

grep -Fq "Included folder pack HideAndGoKill" "$log" || {
    echo "Minecraft did not include the datapack." >&2
    exit 1
}

if grep -Eq '\[(main|Server thread)/ERROR\]|Failed to load function|Couldn.t load .* pack metadata' "$log"; then
    echo "Minecraft reported datapack loading errors." >&2
    exit 1
fi

echo "Minecraft $VERSION datapack smoke test passed."
