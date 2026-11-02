## Zedless 1.0.0

First stable release. No account, no agent panel, no extension store, no
telemetry — now with Zedless branding everywhere and a lower memory floor.

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

- Transparent Zedless logo in the welcome screen; Zedless icons on Linux and
  Windows and Zedless product strings in the Windows executable.
- Fresh installs open the welcome page instead of a throwaway untitled buffer.
- Size-oriented release build: fat LTO, `panic = "abort"`, single codegen unit,
  opt-level=z outside the hot-path allowlist. Editor, terminal, LSP,
  tree-sitter, git, debugger and project search are unchanged.
- Removed the remaining collaboration call stack (LiveKit/WebRTC) from the
  app binary.
- Linux desktop entries no longer request startup notification and duplicate
  activation-token requests were fixed, so the launcher no longer shows a long
  loading cursor.
- Measured RAM, CPU and startup numbers are in the README benchmark table.

### Known limitations

- `client`, `channel` and `extension_host` are still linked to the editor core;
  removing them requires API rework.
- Windows builds are unsigned.
- macOS is not built.

### License and attribution

GPL-3.0-or-later, inherited from Zed. Based on Zed `v1.26.2`
(`c427327`). Zedless is an unofficial fork, not affiliated with Zed Industries.
See `NOTICE` and `LICENSE`.

Checksums are published in `SHA256SUMS.txt`.
