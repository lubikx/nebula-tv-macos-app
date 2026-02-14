# Nebula for macOS

A lightweight floating video player for [nebula.tv](https://nebula.tv). Sits on top of your workspace like a PiP window.

## Features

- Borderless floating window — always on top while you work
- Theater mode — auto-hides Nebula UI when video plays
- Keyboard shortcuts: snap to corner, maximize, toggle always-on-top
- Auto-updates via Sparkle

**Requires macOS 14 (Sonoma) or later.**

## Automated Installation

Paste in Terminal:

```bash
curl -sL https://github.com/lubikx/nebula-macos-app/releases/latest/download/Nebula.dmg -o /tmp/Nebula.dmg && hdiutil attach /tmp/Nebula.dmg -nobrowse -quiet && cp -R "/Volumes/Nebula/Nebula.app" /Applications/ && hdiutil detach "/Volumes/Nebula" -quiet && xattr -cr /Applications/Nebula.app && rm /tmp/Nebula.dmg && echo "Nebula installed!"
```

## Manual Installation

1. Download `Nebula.dmg` from the [Releases](https://github.com/lubikx/nebula-macos-app/releases) page
2. Open the DMG and drag **Nebula.app** to `/Applications`
3. Before first launch, right-click the app → **Open** → click **Open** in the dialog (required once for unsigned apps)

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| Cmd+T | Toggle always on top |
| Cmd+P | Snap to lower-right corner |
| Cmd+Return | Maximize / Restore |
| Escape | Exit theater mode |
