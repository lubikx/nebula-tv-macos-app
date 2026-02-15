# Nebula.tv for macOS

A lightweight floating video player for [nebula.tv](https://nebula.tv). Sits on top of your workspace like a PiP window.

> **Disclaimer:** Nebula is a trademark of [Standard Broadcast LLC](https://standard.tv). This app is not affiliated with, endorsed by, or officially connected to Nebula or Standard Broadcast in any way.

## Features

- Borderless floating window — always on top while you work
- Theater mode — auto-hides Nebula UI when video plays
- Keyboard shortcuts: snap/maximize toggle, always-on-top, full screen
- Auto-updates via Sparkle

**Requires macOS 14 (Sonoma) or later.**

## Install

Paste in Terminal:

```
curl -sL https://raw.githubusercontent.com/lubikx/nebula-macos-app/main/install.sh | bash
```

## Manual Installation

1. Download `Nebula.dmg` from the [Releases](https://github.com/lubikx/nebula-macos-app/releases) page
2. Open the DMG and drag **Nebula.tv.app** to `/Applications`
3. Open Finder → Go → Applications (or press Cmd+Shift+A)
4. Right-click **Nebula.tv** → **Open** → click **Open** in the dialog

> **Why the extra step?** The app isn't signed with an Apple Developer certificate (it's a small personal tool — the $99/year fee isn't worth it). macOS blocks unsigned apps by default, but right-clicking → Open bypasses this once. After that, it launches normally.

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| ⌘ R | Reload page |
| ⌘ T | Toggle always on top |
| ⌘ Enter | Snap / Maximize |
| ⌃ ⌘ F | Full Screen |

## Troubleshooting

If the app misbehaves, reset all settings by running:

```
defaults delete eu.apptory.nebula
```

Then relaunch the app. This clears saved window positions, welcome screen state, and all other preferences.

Alternatively, just re-run the install script — it resets settings automatically.

## Feedback & Support

Have a question, suggestion, or found a bug? Head over to [Discussions](https://github.com/lubikx/nebula-macos-app/discussions).
