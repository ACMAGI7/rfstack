---
name: rf-release
description: Pre-flight a Mac or iPad build, build it, run Apple's pre-upload check, then hard-stop before any upload or notarization submit.
---

# rf-release

Ponytail level full is active for this whole command, including helper agents. Put that same sentence in every helper agent prompt.

No secrets in files. Do not print certificate contents, `.p8` keys, or `apple.env`.

## Step 0 (read-only)
Run `scripts/preflight.sh` (see `/rf-new` for the path lookup). Never fail just because `${CLAUDE_PLUGIN_ROOT}` is unset. Then check, and stop with a plain reason if one fails:
- A signing identity is present (`security find-identity`).
- The build number is set and is newer than the last shipped build (Tauri config, Info.plist, or the project file).
- No signing key, `.p8`, `apple.env`, or updater private key is in git.

## Then
1. Build on a branch. **change, branch-only, ask first.**
2. Apple's pre-upload check: `codesign --verify --strict`, then `xcrun altool --validate-app` only. Do not submit.
3. **HARD STOP.** Do not upload and do not notarize. That includes `xcrun notarytool submit`, `xcrun altool --upload-app`, Transporter, fastlane upload, and `tauri-action` upload. Wait until the user says yes in this chat. A yes is for this run only.

Point at `tauri-apps/tauri-action` (MIT) and fastlane (MIT) if useful. Do not copy them. Signing keys stay in the local keychain or the host's secret store, never in a file in the repo.

## End
Say what was built, the build number, what the pre-upload check reported, and that upload did not happen. Show the cost, or say the cost is unknown. Do not invent a number. Do not merge, push, tag, or release.
