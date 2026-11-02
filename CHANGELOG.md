# Changelog

All notable changes to Zedless are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the project uses
[Semantic Versioning](https://semver.org/).

## [0.1.0] — 2026-11-02

First public release. Based on Zed `v1.26.2`
(`c4273271092b0287f7d181f616bd5171e0a2f70c`).

### Added

- Zedless product identity: own application id, config/data directories
  (`~/.config/zedless`, `~/.local/share/zedless`), logo and desktop entry.
- Linux build script (`script/zedless-build`): opt-level=z, thin LTO, safe ICF,
  LLD and stripped output.
- Per-user installer (`script/zedless-install`), release packaging and a memory
  benchmark script (`script/zedless-mem`).
- Documentation: README, NOTICE, security policy, contribution guide, code of
  conduct, issue templates and release workflow.

### Changed

- Window title, welcome screen, menus, about window and settings text now say
  Zedless.
- Linux rendering uses Vulkan only, and the Vulkan loader is restricted to the
  primary GPU's ICD.
- Defaults: AI disabled, sign-in/profile UI hidden, telemetry off, upstream
  updater off, extension auto-install off.

### Removed

- Agent panel, agents sidebar, ACP tools, inline assistant, Copilot, edit
  prediction, web search and all AI settings pages.
- Collaboration panel, calls/channels UI, collaboration settings page, feedback
  UI and channel-note opening.
- Onboarding flow and its toolbar hints; fresh launches go to the welcome
  screen.
- Crash reporter sidecar, telemetry upload, reliability/hang reporter and the
  upstream auto-updater.
- Extension store menu entries and extension auto-install/suggestion.

### Fixed

- Restored the title bar initialization that used to live in the removed
  collaboration init, so window controls and the hamburger menu are present.
- Keymap loader no longer panics when the default keymap references actions
  that were removed.
- Benchmarks are measured cold-page-cache to avoid fault-around noise.

### Known limitations

- `client`, `call`, `channel` and `extension_host` remain linked to the editor
  core; removing them requires API rework.
- Idle memory is ~147 MB, not 100 MB; GPUI sets a higher floor.
- Windows builds are unsigned and not tested by the maintainer.
- macOS is not built.

[0.1.0]: https://github.com/0xMinomus/zedless/releases/tag/v0.1.0
