#!/usr/bin/env python3
"""Build <id>-<version>.hsm from module/ and print its SHA-256."""
import hashlib
from pathlib import Path
import sys
import zipfile

ROOT = Path(__file__).resolve().parents[1]
MODULE = ROOT / "module"


def field(name):
    for line in (MODULE / "module.properties").read_text().splitlines():
        if line.startswith(name + "="):
            return line.split("=", 1)[1]
    sys.exit(f"module.properties: missing {name}")


def main():
    out = ROOT / "dist" / f"{field('id')}-{field('version')}.hsm"
    out.parent.mkdir(exist_ok=True)
    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as archive:
        for path in sorted(MODULE.rglob("*")):
            if path.is_file() and path.name != ".gitkeep":
                info = zipfile.ZipInfo(path.relative_to(MODULE).as_posix(), (1980, 1, 1, 0, 0, 0))
                info.compress_type = zipfile.ZIP_DEFLATED
                archive.writestr(info, path.read_bytes())
    digest = hashlib.sha256(out.read_bytes()).hexdigest()
    print(out)
    print(digest)


if __name__ == "__main__":
    main()
