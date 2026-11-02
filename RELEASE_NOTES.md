## Zedless 0.1.0

A lightweight, local-first fork of Zed. No account, no agent panel, no
extension store, no telemetry.

### Downloads

| Platform | Asset |
|---|---|
| Linux x86_64 | `zedless-linux-x86_64.tar.gz` |
| Windows x86_64 | `zedless-windows-x86_64.zip` |
| Checksums | `SHA256SUMS.txt` |

### Linux

```sh
tar -xzf zedless-linux-x86_64.tar.gz
cd zedless-linux-x86_64
./install.sh
```

Installs to `~/.local` (binary in `~/.local/lib/zedless`, launcher `zedless`,
desktop entry and icon). Uninstall instructions are in the README.

### Windows

Extract `zedless-windows-x86_64.zip` and run `zedless.exe`. The build is
portable. It is unsigned, so SmartScreen will warn; verify the SHA-256 before
running.

### Highlights

- Editor core, LSP, tree-sitter, terminal, git, debugger and project search kept.
- Agent panel, AI providers, Copilot, edit prediction, collaboration UI,
  extension store, onboarding, crash reporter, telemetry and upstream updater
  removed.
- ~2× lighter than Zed on the same workload: 148 MB idle versus 294 MB
  (measured on one Fedora 44 / Intel machine, cold page cache).
- Own application id, config/data directories, logo and desktop entry.

### Known limitations

- `client`, `call`, `channel` and `extension_host` are still linked to the
  editor core; removing them requires API rework.
- Idle memory floor is ~147 MB with GPUI; 100 MB is not reachable yet.
- Windows build is unsigned and not tested by the maintainer.
- macOS is not built.

### License and attribution

GPL-3.0-or-later, inherited from Zed. Based on Zed `v1.26.2`
(`c427327`). Zedless is an unofficial fork, not affiliated with Zed Industries.
See `NOTICE` and `LICENSE`.

Checksums are published in `SHA256SUMS.txt`.
