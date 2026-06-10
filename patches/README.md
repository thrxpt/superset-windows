# Patches

`*.patch` files in this directory are applied to the upstream checkout with `git apply` before building, in lexical order. Name them `NNN-short-description.patch`.

A patch that no longer applies fails the build — that's intentional: it means upstream drifted and the patch must be regenerated against the new tag.

Currently empty: the Windows build works with the overlay config alone.
