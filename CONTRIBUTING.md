# Contributing to Zedless

Thanks for wanting to help. Zedless is a small fork with a deliberately narrow
scope: a fast, local editor without accounts, agents or an extension store.

## Before you start

- **Bugs and features:** open an issue using the templates. For security
  problems, follow [SECURITY.md](SECURITY.md) instead.
- **Large changes:** open an issue first so we can agree on scope. Features
  that re-introduce cloud, AI or collaboration surfaces are out of scope.
- **Fork sync:** Zedless follows upstream Zed selectively. Mention if a change
  is a security fix that should be cherry-picked.

## Development setup

Requirements are listed in the README. On Linux:

```sh
./script/linux                 # distro dependencies
cargo check -p zed             # fast feedback
cargo build --profile release-fast -p zed
```

Release builds:

```sh
script/zedless-build           # ~15-25 min, produce target/release/zedless
script/zedless-mem target/release/zedless
```

## What we look for in a PR

- Focused diff: one problem per pull request.
- Behaviour verified locally (describe how in the PR).
- No new network calls, telemetry, accounts, agents, or extension-store logic.
- No unrelated formatting churn.
- Public APIs and settings changes documented in the PR description.
- New code is GPL-3.0-or-later compatible.

AI-assisted contributions are fine, but you are responsible for reviewing,
understanding and testing the result.

## Commit messages

Conventional Commits are preferred:

```
fix(editor): avoid panic when closing the last pane
feat(ui): add Zedless welcome actions
docs: clarify Linux install steps
```

## License

By contributing you agree that your contribution is licensed under
GPL-3.0-or-later, the same license as the project. There is no CLA.
