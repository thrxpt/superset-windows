# superset-windows

Unofficial Windows x64 builds of [Superset](https://github.com/superset-sh/superset) — the code editor for the AI agents era. Upstream ships macOS (and a Linux AppImage) only; this repo builds the same source for Windows and serves it as a [scoop](https://scoop.sh) bucket.

> **Unofficial.** Not affiliated with or endorsed by the Superset team. Binaries are built unmodified (or with the minimal patches in [`patches/`](patches/)) from upstream tags by GitHub Actions — every release links the exact upstream release it was built from.

## Install

```powershell
scoop bucket add superset https://github.com/thrxpt/superset-windows
scoop install superset
```

Or download the NSIS installer from [Releases](https://github.com/thrxpt/superset-windows/releases). Builds are **unsigned** — SmartScreen will warn on the installer (More info → Run anyway). Scoop installs are unaffected.

## Updates

- **Scoop**: `scoop update superset`
- **NSIS install**: the app self-updates from this repo's releases

## How it works

- [`check-upstream.yml`](.github/workflows/check-upstream.yml) polls upstream every 6 hours for new stable `desktop-v*` releases and dispatches a build.
- [`build-windows.yml`](.github/workflows/build-windows.yml) clones upstream at the tag, applies any patches from `patches/`, drops in the [overlay config](overlay/electron-builder.win.ts) (adds zip target, points auto-update here), builds with electron-builder on a `windows-latest` runner, smoke-tests the packaged app, publishes a GitHub release, and bumps the scoop manifest.
- Our tag `vX.Y.Z` always corresponds to upstream `desktop-vX.Y.Z`. A packaging-only rebuild gets a suffix (`vX.Y.Z-2`).

Manual build: Actions → Build Windows → Run workflow with the upstream tag.

## License

Superset is licensed under the [Elastic License 2.0](https://github.com/superset-sh/superset/blob/main/LICENSE.md), which permits redistribution of builds. The binaries published here remain under ELv2. The build scripts in this repo are MIT.
