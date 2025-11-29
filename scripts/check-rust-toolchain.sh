#!/usr/bin/env bash
set -euo pipefail

REQUIRED_RUST="1.84.0"

echo "=== TFHE-rs Rust toolchain check ==="
echo

# Check rustc presence
if ! command -v rustc >/dev/null 2>&1; then
  echo "Error: rustc is not installed or not in PATH."
  echo "Please install Rust via rustup (https://rustup.rs/) before building TFHE-rs."
  exit 1
fi

RUST_VERSION_RAW="$(rustc --version)"
RUST_VERSION="$(echo "${RUST_VERSION_RAW}" | awk '{print $2}')"

echo "Detected rustc: ${RUST_VERSION_RAW}"

# Version comparison using sort -V
if [ "$(printf '%s\n%s\n' "${REQUIRED_RUST}" "${RUST_VERSION}" | sort -V | head -n1)" != "${REQUIRED_RUST}" ]; then
  echo
  echo "Warning: your Rust version (${RUST_VERSION}) is older than the recommended ${REQUIRED_RUST}."
  echo "TFHE-rs documentation recommends Rust ${REQUIRED_RUST} or newer."
  echo "You can update with:"
  echo "  rustup update stable"
else
  echo
  echo "OK: Rust version meets the recommended minimum (${REQUIRED_RUST} or newer)."
fi

echo

# Basic architecture hint
UNAME_S="$(uname -s 2>/dev/null || echo "unknown")"
UNAME_M="$(uname -m 2>/dev/null || echo "unknown")"

echo "Host platform:"
echo "  uname -s: ${UNAME_S}"
echo "  uname -m: ${UNAME_M}"
echo

if echo "${UNAME_M}" | grep -iq "aarch64"; then
  cat <<EOF
Note: TFHE-rs documentation mentions that AArch64-based machines
are not supported on Windows due to missing entropy sources for
the CSPRNGs. If you are on Windows with AArch64, you may encounter
additional limitations or build issues.
EOF
fi

echo
echo "Toolchain check completed."
echo "If you still encounter build problems, please compare your setup"
echo "with the recommendations in the TFHE-rs README and documentation."
