#!/usr/bin/env python3
"""Canonical in-memory runner for the independent Response 42 stress scan."""

from __future__ import annotations

import hashlib
import os
import subprocess


EXECUTABLE = os.environ.get(
    "RESPONSE42_CHEB_STRESS_BIN", "/tmp/response42_cheb_stress"
)

COMMANDS = (
    (EXECUTABLE, "15", "22", "0", "scan"),
    (EXECUTABLE, "16", "22", "0", "box"),
    (EXECUTABLE, "17", "23", "0", "box"),
    (EXECUTABLE, "18", "24", "0", "box"),
    (EXECUTABLE, "19", "25", "0", "box"),
    (EXECUTABLE, "20", "26", "0", "box"),
)


def main() -> None:
    output = b"".join(subprocess.check_output(command) for command in COMMANDS)
    print(output.decode(), end="")
    print(f"OUTPUT_SHA256={hashlib.sha256(output).hexdigest()}")


if __name__ == "__main__":
    main()
