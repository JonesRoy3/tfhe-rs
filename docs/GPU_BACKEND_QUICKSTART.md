# GPU backend quickstart for TFHE-rs

This document gives a short, practical checklist for enabling and
testing the GPU backend of TFHE-rs.

For full details, please refer to the official documentation page about
GPU acceleration and benchmarks.

---

## 1. Prerequisites

Before enabling the GPU backend, make sure your machine satisfies the
following requirements:

- Operating system:
  - Linux on x86_64 or aarch64
- CUDA toolkit:
  - CUDA version 10 or newer installed and available in `PATH`
- GPU:
  - NVIDIA GPU with compute capability 3.0 or higher
- Build toolchain:
  - `gcc` 8.0 or newer
  - `cmake` 3.24 or newer
  - a recent `libclang` installation compatible with Rust bindgen
- Rust:
  - a Rust toolchain recent enough for the TFHE-rs version you are using

If you are unsure about these requirements, please check the hardware
acceleration section in the TFHE-rs documentation for the latest
details.

---

## 2. Cargo.toml configuration

To enable the GPU backend in a project that depends on TFHE-rs, add the
`gpu` feature in your `Cargo.toml`:

```toml
[dependencies]
tfhe = { version = "~1.4.2", features = ["boolean", "shortint", "integer", "gpu"] }
