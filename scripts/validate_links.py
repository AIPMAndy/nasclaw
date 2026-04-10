#!/usr/bin/env python3
"""Basic internal markdown link validator for NASClaw docs."""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MARKDOWN_FILES = sorted(ROOT.rglob("*.md"))
LINK_RE = re.compile(r"\[[^\]]+\]\(([^)]+)\)")
ANCHOR_RE = re.compile(r"[^a-z0-9\-\u4e00-\u9fff ]")


def normalize_anchor(text: str) -> str:
    text = text.strip().lower()
    text = ANCHOR_RE.sub("", text)
    text = text.replace(" ", "-")
    text = re.sub(r"-+", "-", text)
    return text.strip("-")


def collect_anchors(path: Path) -> set[str]:
    anchors: set[str] = set()
    for line in path.read_text(encoding="utf-8").splitlines():
        if line.startswith("#"):
            title = line.lstrip("#").strip()
            if title:
                anchors.add(normalize_anchor(title))
    return anchors


def validate() -> list[str]:
    errors: list[str] = []
    anchor_cache: dict[Path, set[str]] = {}

    for md in MARKDOWN_FILES:
        text = md.read_text(encoding="utf-8")
        for match in LINK_RE.finditer(text):
            raw = match.group(1).strip()
            if not raw or raw.startswith(("http://", "https://", "mailto:", "#")):
                if raw.startswith("#"):
                    anchors = anchor_cache.setdefault(md, collect_anchors(md))
                    if normalize_anchor(raw[1:]) not in anchors:
                        errors.append(f"{md.relative_to(ROOT)}: missing anchor {raw}")
                continue
            if raw.startswith("javascript:"):
                errors.append(f"{md.relative_to(ROOT)}: unsafe link {raw}")
                continue
            target, _, anchor = raw.partition("#")
            target_path = (md.parent / target).resolve()
            if not target_path.exists():
                errors.append(f"{md.relative_to(ROOT)}: missing file {raw}")
                continue
            if anchor:
                anchors = anchor_cache.setdefault(target_path, collect_anchors(target_path))
                if normalize_anchor(anchor) not in anchors:
                    errors.append(f"{md.relative_to(ROOT)}: missing anchor {raw}")
    return errors


if __name__ == "__main__":
    problems = validate()
    if problems:
        print("Link validation failed:")
        for item in problems:
            print(f"- {item}")
        sys.exit(1)
    print(f"Validated {len(MARKDOWN_FILES)} markdown files.")
