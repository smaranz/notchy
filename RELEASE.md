# Notchy Release Guide (No Apple Dev Account)

This project is distributed as an unsigned macOS app. Users can run it, but Gatekeeper will show a warning on first launch. This is expected without notarization.

## User Install (from GitHub Releases)

1) Download the latest `Notchy-*.zip` from GitHub Releases.
2) Unzip it to get `Notchy.app`.
3) Move `Notchy.app` to `/Applications`.
4) First launch:
   - Right‑click `Notchy.app` → **Open** → **Open** again, or
   - Run:
     ```bash
     xattr -dr com.apple.quarantine /Applications/Notchy.app
     ```

## Maintainer Build (local, unsigned)

Use the release script to generate a zip you can upload to GitHub Releases.

```bash
./scripts/build_release.sh
```

Output goes to `dist/`.
