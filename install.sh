#!/bin/bash
set -e

# ─── Colors & Symbols ───────────────────────────────────────
BOLD=$'\033[1m'
DIM=$'\033[2m'
RESET=$'\033[0m'
GREEN=$'\033[32m'
RED=$'\033[31m'
CYAN=$'\033[36m'
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
    echo -e "\r  ${CHECK} ${1}    "
}
fail_step() {
    echo -e "\r  ${CROSS} ${1}    "
    echo -e "\n  ${RED}Installation failed.${RESET}\n"
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
answer=""
if [ -t 0 ]; then
    echo -ne "  Launch now? ${DIM}[Y/n]${RESET} "
    read -r answer
elif [ -c /dev/tty ] 2>/dev/null; then
    echo -ne "  Launch now? ${DIM}[Y/n]${RESET} "
    read -r answer < /dev/tty
fi

if [ -z "$answer" ] || [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    open "/Applications/Nebula.tv.app"
    echo -e "  ${CHECK} Launched. Enjoy!"
else
    echo -e "  ${DIM}Open it anytime from /Applications.${RESET}"
fi
echo ""
