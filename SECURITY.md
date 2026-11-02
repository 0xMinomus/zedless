# Security Policy

## Supported versions

| Version | Supported |
|---|---|
| 0.1.x | Yes |

Only the latest release receives fixes.

## Reporting a vulnerability

Please **do not** open a public issue for security problems.

Use GitHub's private vulnerability reporting:

1. Open the repository's **Security** tab.
2. Choose **Report a vulnerability**.
3. Describe the issue, affected version, and reproduction steps.

If that is unavailable, contact the maintainer on GitHub: [@0xMinomus](https://github.com/0xMinomus).

You can expect an acknowledgement within a few days. Please allow time for a fix
before public disclosure.

## Scope

Zedless is a local editor built from the Zed codebase. Relevant reports include:

- memory-safety issues reachable from opened files, workspaces or language servers,
- path traversal or arbitrary code execution through local project files,
- privilege escalation through the bundled installer scripts,
- supply-chain issues in release artifacts.

Out of scope: vulnerabilities in third-party language servers, system
libraries, GPU drivers, or upstream Zed code that also affects upstream
(please report those upstream as well).

## Release integrity

Release archives are published with SHA-256 checksums in the release notes.
Builds are produced from the tagged source in this repository by the release
workflow. Windows builds are unsigned; verify the checksum before running.
