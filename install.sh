#!/bin/bash
set -e

# ─── Colors & Symbols ───────────────────────────────────────
BOLD='[1m'
DIM='[2m'
RESET='[0m'
BLUE='[34m'
GREEN='[32m'
RED='[31m'
CYAN='[36m'
CHECK="${GREEN}✓${RESET}"
ARROW="${CYAN}→${RESET}"
CROSS="${RED}✗${RESET}"

# ─── Parse args ──────────────────────────────────────────────
VERSION=""
while getopts "s:" opt; do
    case $opt in
        s) VERSION="$OPTARG" ;;
        *) ;;
    esac
done

if [ -n "$VERSION" ]; then
    URL="https://github.com/lubikx/nebula-macos-app/releases/download/v${VERSION}/Nebula.dmg"
else
    URL="https://github.com/lubikx/nebula-macos-app/releases/latest/download/Nebula.dmg"
fi

# ─── Header ──────────────────────────────────────────────────
echo ""
echo -e "  ${BOLD}Nebula.tv for macOS${RESET}"
if [ -n "$VERSION" ]; then
    echo -e "  ${DIM}Version ${VERSION}${RESET}"
fi
echo -e "  ${DIM}────────────────────${RESET}"
echo ""

# ─── Step helper ─────────────────────────────────────────────
step() {
    echo -ne "  ${ARROW} ${1}..."
}
done_step() {
    echo -e "  ${CHECK} ${1}    "
}
fail_step() {
    echo -e "  ${CROSS} ${1}    "
    echo -e "
  ${RED}Installation failed.${RESET}
"
    exit 1
}

# ─── Install ─────────────────────────────────────────────────
step "Downloading"
if ! curl -sL "$URL" -o /tmp/Nebula.dmg 2>/dev/null; then
    fail_step "Download failed"
fi
done_step "Downloaded"

step "Mounting disk image"
if ! hdiutil attach /tmp/Nebula.dmg -nobrowse -quiet 2>/dev/null; then
    fail_step "Mount failed"
fi
done_step "Mounted"

step "Installing to /Applications"
if ! cp -R "/Volumes/Nebula/Nebula.tv.app" /Applications/ 2>/dev/null; then
    hdiutil detach "/Volumes/Nebula" -quiet 2>/dev/null
    fail_step "Copy failed"
fi
done_step "Installed"

step "Cleaning up"
hdiutil detach "/Volumes/Nebula" -quiet 2>/dev/null
xattr -cr "/Applications/Nebula.tv.app" 2>/dev/null
rm -f /tmp/Nebula.dmg
done_step "Cleaned up"

# ─── Done ────────────────────────────────────────────────────
echo ""
echo -e "  ${GREEN}${BOLD}Nebula.tv for macOS installed!${RESET}"
echo ""

# ─── Launch prompt ───────────────────────────────────────────
echo -ne "  Launch now? ${DIM}[Y/n]${RESET} "
read -r answer
if [[ -z "$answer" || "$answer" =~ ^[Yy]$ ]]; then
    open "/Applications/Nebula.tv.app"
    echo -e "  ${CHECK} Launched. Enjoy! 🚀"
else
    echo -e "  ${DIM}Open it anytime from /Applications.${RESET}"
fi
echo ""
