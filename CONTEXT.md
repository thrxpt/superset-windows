# Context

Glossary for the superset-windows builder. Terms here are the canonical language for issues, commits, and docs.

## Terms

### Upstream
The source project, [superset-sh/superset](https://github.com/superset-sh/superset). We never modify it directly; we build from its tags.

### Builder repo
This repository. It contains no application source — only the machinery (workflows, overlay, patches, bucket) to produce Windows builds from Upstream.

### Overlay
A file copied on top of an Upstream checkout at build time without modifying any Upstream file. Overlays carry Windows-specific configuration.

### Patch
A change to an Upstream source file, stored as a `.patch` file and applied with `git apply`. A Patch that no longer applies fails the build loudly — that is the signal Upstream drifted and the Patch needs updating.

### Bucket
The scoop bucket served from this repo (`bucket/`). The Manifest inside it describes the installable package.

### Manifest
`bucket/superset.json` — scoop's package definition: version, download URL, hash. Bumped automatically after each release.

### Stable channel
Upstream releases tagged `desktop-vX.Y.Z` that are neither drafts, prereleases, nor canary builds. Only Stable channel releases are built here.

### Rebuild
A new build of the same Upstream version (packaging fix, patch update). Tagged with a numeric suffix: `v1.12.5-2`.
