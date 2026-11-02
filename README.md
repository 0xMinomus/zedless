# Zedless

<p align="center">
  <img src="assets/zedless-logo.png" width="112" alt="Zedless logo">
</p>

<p align="center">
  A lightweight, local-first fork of <a href="https://github.com/zed-industries/zed">Zed</a>.<br>
  No account, no agent panel, no extension store, no telemetry.
</p>

<p align="center">
  <a href="LICENSE"><img alt="License: GPL-3.0-or-later" src="https://img.shields.io/badge/license-GPL--3.0--or--later-blue"></a>
  <a href="https://github.com/0xMinomus/zedless/releases"><img alt="Latest release" src="https://img.shields.io/github/v/release/0xMinomus/zedless?include_prereleases"></a>
  <img alt="Platforms" src="https://img.shields.io/badge/platform-linux%20%7C%20windows-lightgrey">
</p>

Zedless keeps Zed's editor core and native UI, then removes the surfaces that
make an editor heavy: the agent panel, AI providers, collaboration UI, extension
store, crash reporter, telemetry upload and the upstream updater. What is left is
a fast local editor with LSP, tree-sitter, terminals, git, debugger, project
search and multi-cursor editing.

Zedless is an **unofficial fork**. It is not affiliated with, endorsed by, or
supported by Zed Industries. See [NOTICE](NOTICE) and [Trademark](#trademark).

## Status

- **0.1.0** — first public build.
- Linux x86_64: tested, released as a tarball.
- Windows x86_64: portable zip produced by the release workflow; unsigned, so
  SmartScreen will warn on first launch.
- macOS: not built; the fork is not tested there.

## Features

| Kept | Removed |
|---|---|
| Editor core: rope buffer, multi-cursor, vim mode | Agent panel, ACP tools, sidebar threads |
| Tree-sitter syntax + LSP (Rust, TS/JS, Python, Go, C/C++, JSON, CSS, YAML, …) | AI providers, copilot, inline assist, edit prediction |
| Project panel, search, outline, git panel, debugger, terminal | Collaboration panel, calls, channel UI |
| Settings UI, keymaps, themes (built-in) | Extension store and extension auto-install |
| Local-first: no login, no cloud calls on startup | Crash reporter, telemetry upload, upstream updater |

## Memory benchmark

Measured on one machine (Fedora 44, Intel RAPTORLAKE-S, Mesa 26.2.4), fresh
profile, cold page cache, RSS summed across all editor processes:

| Scenario | Zed 1.26.2 | Zedless 0.1 |
|---|---:|---:|
| Idle / welcome | 294 MB (256 + 38 crash helper) | **148 MB** |
| Open project (20 s) | 296 MB (258 + 38) | **147 MB** |
| Binary | 220 MB | **188 MB** |
| `.text` | 155.5 MB | **132.5 MB** |

Zedless is roughly **2× lighter** than Zed on the same workload. Values vary
with page-cache state and GPU driver; run `script/zedless-mem` to reproduce.

### Known limitations

- `client`, `call`, `channel` and `extension_host` are still linked because the
  editor core depends on them. Removing them needs editor/project API rework,
  not UI trimming.
- ~100 MB idle is not reachable with GPUI as-is; the practical floor here is
  ~145–150 MB.
- Windows builds are unsigned and untested by the maintainer at release time.

## Install

### Linux (x86_64)

Download `zedless-linux-x86_64.tar.gz` from the
[latest release](https://github.com/0xMinomus/zedless/releases/latest), then:

```sh
tar -xzf zedless-linux-x86_64.tar.gz
cd zedless-linux-x86_64
./install.sh
```

This installs the binary to `~/.local/lib/zedless`, the `zedless` launcher to
`~/.local/bin`, a desktop entry and the icon. Start it from the application menu
or with `zedless /path/to/project`.

Uninstall:

```sh
rm -rf ~/.local/lib/zedless ~/.local/bin/zedless \
  ~/.local/share/applications/dev.zedless.Zedless.desktop \
  ~/.local/share/icons/hicolor/512x512/apps/zedless.png
```

### Windows (x86_64)

Download `zedless-windows-x86_64.zip`, extract it anywhere and run
`zedless.exe`. The build is portable: settings live in `%APPDATA%\Zedless`.
Windows SmartScreen will warn because the binary is unsigned; use *More info →
Run anyway* only if you trust the release checksum.

### Build from source

Requirements: Rust 1.98+, clang, lld, llvm-objcopy, protoc and the Linux
dependencies installed by `script/linux` (Fedora/Debian/Arch/openSUSE).

```sh
script/zedless-build          # release binary at target/release/zedless
script/zedless-install       # user install into ~/.local
```

Fast iteration: `cargo build --profile release-fast -p zed`.

## Repository layout

| Path | Purpose |
|---|---|
| `crates/zed` | application entry, window/workspace wiring |
| `crates/editor`, `crates/project` | editor and LSP/project core |
| `crates/gpui*` | UI framework |
| `script/zedless-build` | reproducible release build (opt-level=z, thin LTO, ICF, strip) |
| `script/zedless-install` | per-user install |
| `script/zedless-mem` | idle memory benchmark |
| `packaging/` | archive installer used by releases |

## Contributing

Contributions are welcome. Read [CONTRIBUTING.md](CONTRIBUTING.md) first.
Please also read the [Code of Conduct](CODE_OF_CONDUCT.md). Security issues go
through [SECURITY.md](SECURITY.md), not public issues.

## License

Zedless is distributed under **GPL-3.0-or-later**, inherited from Zed. You may
use, modify and redistribute it under the same license; if you distribute a
binary you must also make the corresponding source available. See [LICENSE](LICENSE),
[LICENSE-GPL](LICENSE-GPL) and [LICENSE-APACHE](LICENSE-APACHE).

Upstream: [zed-industries/zed](https://github.com/zed-industries/zed), based on
tag `v1.26.2` (commit `c4273271092b0287f7d181f616bd5171e0a2f70c`).

## Trademark

“Zed” and the Zed logo are trademarks of Zed Industries. Zedless uses its own
name and logo, does not ship Zed branding, and is not affiliated with Zed
Industries. The Zedless name and logo identify this fork only.
