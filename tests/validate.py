#!/usr/bin/env python3
"""Static validation for the Hide and Go Kill datapack."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
FUNCTION_CALL = re.compile(
    r"(?:^|\s)(?:schedule\s+function|function)\s+"
    r"(?P<id>[#a-z0-9_.-]+:[a-z0-9_./-]+)"
)


def fail(message: str) -> None:
    errors.append(message)


errors: list[str] = []

legacy_directories = (
    ROOT / "data/hagk/functions",
    ROOT / "data/minecraft/tags/functions",
)
for path in legacy_directories:
    if path.exists():
        fail(f"legacy Minecraft 1.20 directory still exists: {path.relative_to(ROOT)}")

function_root = ROOT / "data/hagk/function"
tag_root = ROOT / "data/minecraft/tags/function"
if not function_root.is_dir():
    fail("missing data/hagk/function")
if not tag_root.is_dir():
    fail("missing data/minecraft/tags/function")

json_files = sorted(ROOT.glob("data/**/*.json")) + [ROOT / "pack.mcmeta"]
documents: dict[Path, object] = {}
for path in json_files:
    try:
        documents[path] = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        fail(f"invalid JSON in {path.relative_to(ROOT)}: {exc}")

metadata = documents.get(ROOT / "pack.mcmeta")
if isinstance(metadata, dict) and isinstance(metadata.get("pack"), dict):
    pack = metadata["pack"]
    if pack.get("pack_format") != 61:
        fail("pack.mcmeta pack_format must remain 61 for the legacy metadata range")
    if pack.get("supported_formats") != [48, 100]:
        fail("pack.mcmeta supported_formats must be [48, 100]")
    if pack.get("min_format") != 48 or pack.get("max_format") != 100:
        fail("pack.mcmeta must declare min_format 48 and max_format 100")
else:
    fail("pack.mcmeta must contain a pack object")

function_ids: set[str] = set()
if function_root.is_dir():
    for path in function_root.rglob("*.mcfunction"):
        relative = path.relative_to(function_root).with_suffix("")
        function_ids.add(f"hagk:{relative.as_posix()}")

references: list[tuple[Path, int, str]] = []
for path in sorted(function_root.rglob("*.mcfunction")) if function_root.is_dir() else []:
    text = path.read_text(encoding="utf-8")
    if text and not text.endswith("\n"):
        fail(f"{path.relative_to(ROOT)} does not end with a newline")
    for number, line in enumerate(text.splitlines(), start=1):
        stripped = line.strip()
        if not stripped or stripped.startswith("#"):
            continue
        match = FUNCTION_CALL.search(line)
        if match and not match.group("id").startswith("#"):
            references.append((path, number, match.group("id")))

for path in sorted(tag_root.glob("*.json")) if tag_root.is_dir() else []:
    document = documents.get(path)
    if not isinstance(document, dict) or not isinstance(document.get("values"), list):
        fail(f"{path.relative_to(ROOT)} must contain a values array")
        continue
    for value in document["values"]:
        if isinstance(value, str) and not value.startswith("#"):
            references.append((path, 0, value))

for path, number, function_id in references:
    if function_id.startswith("hagk:") and function_id not in function_ids:
        location = f"{path.relative_to(ROOT)}:{number}" if number else str(path.relative_to(ROOT))
        fail(f"{location} references missing function {function_id}")

if errors:
    for error in errors:
        print(f"ERROR: {error}", file=sys.stderr)
    raise SystemExit(1)

print(
    f"Validated {len(function_ids)} functions, "
    f"{len(json_files)} JSON files, and {len(references)} function references."
)
