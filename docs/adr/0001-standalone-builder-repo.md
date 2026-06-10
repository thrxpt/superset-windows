# 0001 — Standalone builder repo instead of a fork

## Status

Accepted (2026-06-11)

## Context

Superset ships no Windows binaries, but its source already defines a Windows electron-builder target and its CLI bundler supports windows-x64. Producing Windows builds therefore requires CI machinery, not an application port. Three homes for that machinery were considered:

1. **Fork superset-sh/superset** and add a Windows job on a patch branch.
2. **Standalone builder repo** that clones upstream at a tag and builds it.
3. **Upstream PR** adding the Windows job to their CI.

## Decision

Standalone builder repo (`thrxpt/superset-windows`), which also hosts the scoop bucket and the published releases.

## Consequences

- No fork-sync maintenance: upstream is consumed read-only at release tags, so upstream churn between releases is invisible to us.
- The entire Windows delta is explicit and small: one overlay config plus zero-or-more patch files. A fork would bury the delta in a branch diff.
- Patches fail loudly (`git apply --check`) when upstream drifts — drift is detected at build time, not silently merged.
- Releases, the scoop bucket, and the auto-update feed live at one URL, which scoop manifests and electron-updater both point at. Reversing this decision after users have added the bucket means breaking their install/update path — this is the hard-to-reverse part.
- Trade-off accepted: we cannot reuse upstream's CI history or secrets, and we re-declare the build steps (mirroring their `build-desktop.yml`) ourselves.
- An upstream PR remains possible later; this repo would then shrink to just the bucket.
