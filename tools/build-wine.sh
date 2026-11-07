#!/bin/sh
# Builds the Windows launcher on Linux (mingw cross build) with the web view set up for Wine on Haiku:
# WebView2 gets software rendering and no sandbox through additionalBrowserArgs (src-tauri/tauri.wine.conf.json).
# Needs: rustup (the toolchain of rust-toolchain.toml), nodejs + npm, mingw-w64-gcc.
# Output: target/x86_64-pc-windows-gnu/release/netcodeplus-launcher.exe
set -e
cd "$(dirname "$0")/.."
rustup target add x86_64-pc-windows-gnu
[ -d node_modules ] || npm ci
export CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER=x86_64-w64-mingw32-gcc
npm run tauri -- build --target x86_64-pc-windows-gnu --config src-tauri/tauri.wine.conf.json --no-bundle
ls -la target/x86_64-pc-windows-gnu/release/netcodeplus-launcher.exe
