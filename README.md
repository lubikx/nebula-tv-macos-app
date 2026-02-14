# Nebula for macOS

A lightweight floating video player for [nebula.tv](https://nebula.tv). Sits on top of your workspace like a PiP window.

## Features

- Borderless floating window — always on top while you work
- Theater mode — auto-hides Nebula UI when video plays
- Keyboard shortcuts: snap to corner, maximize, toggle always-on-top
- Auto-updates via Sparkle

**Requires macOS 14 (Sonoma) or later.**

## Install

Paste in Terminal:

```
curl -sL raw.githubusercontent.com/lubikx/nebula-macos-app/main/install.sh | bash
```

To install a specific version (e.g. for testing updates):

```
curl -sL raw.githubusercontent.com/lubikx/nebula-macos-app/main/install.sh | bash -s 1.0.0
```

## Manual Installation

1. Download `Nebula.dmg` from the [Releases](https://github.com/lubikx/nebula-macos-app/releases) page
2. Open the DMG and drag **Nebula.app** to `/Applications`
3. Open Finder → Go → Applications (or press Cmd+Shift+A)
4. Right-click **Nebula** → **Open** → click **Open** in the dialog

> **Why the extra step?** The app isn't signed with an Apple Developer certificate (it's a small personal tool — the $99/year fee isn't worth it). macOS blocks unsigned apps by default, but right-clicking → Open bypasses this once. After that, it launches normally.

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| Cmd+T | Toggle always on top |
| Cmd+P | Snap to lower-right corner |
| Cmd+Return | Maximize / Restore |
| Escape | Exit theater mode |
