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

- **1.0.0** — first stable release.
- Linux x86_64: tested, released as a tarball.
- Windows x86_64: stable, tested by the maintainer; shipped as a portable zip.
  The build is unsigned, so SmartScreen will warn on first launch.
- macOS: not built; the fork is not tested there.

## What changed in 1.0.0

Compared with Zedless 0.1.0:

| Area | 0.1.0 | 1.0.0 |
|---|---|---|
| Branding | Zed logo in the UI, Zed app icons | Transparent Zedless logo everywhere, Zedless icons and Windows metadata |
| First launch | empty `untitled` buffer | welcome page, window titled "Zedless" |
| Collaboration runtime | `call`/LiveKit/WebRTC and the title-bar call UI still linked | removed from the binary |
| Startup | authenticated with the collaboration service | fully local: no cloud connection, no font prewarm |
| Loading cursor | `StartupNotify=true` and duplicate activation tokens | fixed: no lingering launch cursor |
| Release build | opt-level=z, thin LTO, safe ICF | fat LTO, `panic=abort`, single codegen unit, gc-sections |
| Idle memory | no page reclaim | clean code pages returned to the OS after ~5 s idle (Linux) |

| Metric | 0.1.0 | 1.0.0 |
|---|---:|---:|
| **RAM, idle** | 136 MB | **52 MB** |
| **RAM, project open** | 157 MB | **65 MB** |
| Binary | 186.6 MB | **116 MB** |
| Processes / threads | 1 / 57 | 1 / 58 |
| CPU, idle | 0.0 % | **0.0 %** |

Both rows use the same machine, fresh profile and cold page cache. The 0.1.0
numbers were recorded before the idle page reclaim existed.

## Features

| Kept | Removed |
|---|---|
| Editor core: rope buffer, multi-cursor, vim mode | Agent panel, ACP tools, sidebar threads |
| Tree-sitter syntax + LSP (Rust, TS/JS, Python, Go, C/C++, JSON, CSS, YAML, …) | AI providers, copilot, inline assist, edit prediction |
| Project panel, search, outline, git panel, debugger, terminal | Collaboration panel, calls, channel UI |
| Settings UI, keymaps, themes (built-in) | Extension store and extension auto-install |
| Local-first: no login, no cloud connection on startup | Crash reporter, telemetry upload, upstream updater |

## Memory and CPU benchmark

One machine (Fedora 44, Intel RAPTORLAKE-S, Mesa 26.2.4), fresh profile, cold
page cache, same protocol for both editors:

| Metric | Zed 1.26.2 | Zedless 1.0.0 |
|---|---:|---:|
| **RAM, idle** | 245 MB | **52 MB** |
| **RAM, project open** | 257 MB | **65 MB** |
| CPU, idle (mean over 15 s) | 0.0 % | **0.0 %** |
| Time to first frame (cold cache) | 0.69 s | **0.69 s** |
| Processes / threads | 2 / 91 | **1 / 58** |
| Binary | 230 MB | **116 MB** |

How it was measured: RSS and PSS come from `/proc/<pid>/smaps_rollup`, summed
over the process tree. Each run starts from a fresh profile with the page cache
dropped; idle is read 12 s after launch and project is `zed/crates` (83 MB)
opened for 25 s. Language servers are separate processes and are not counted
for either app.

Zedless is **~4.7× lighter than Zed at idle** and **~4× lighter with a project
open**, while both spend 0.0 % CPU when nothing is happening. Two things bring
the idle footprint down:

- The release binary is built with fat LTO, `panic = "abort"`, single codegen
  unit and opt-level=z outside the hot-path allowlist. The remaining
  collaboration call stack (LiveKit/WebRTC) is not linked.
- On Linux, after ~5 s without CPU activity the process hands its clean
  executable and read-only pages back to the OS. The pages stay in the page
  cache and re-fault instantly on the next interaction, so documents, settings
  and rendering state are untouched. Without that reclaim the idle figure is
  ~108 MB.

Reproduce RAM with `script/zedless-mem`; CPU numbers require a process-tree
sampler.

### Known limitations

- `client`, `channel` and `extension_host` are still linked because the editor
  core depends on them. Removing them needs editor/project API rework.
- The idle page reclaim is Linux-only. Windows uses the OS working-set
  manager.
- Windows builds are unsigned; SmartScreen warns on first launch. They are
  tested stable by the maintainer.

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
| `script/zedless-build` | reproducible release build (opt-level=z, fat LTO, panic=abort, ICF, strip) |
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
