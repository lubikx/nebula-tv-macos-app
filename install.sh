#!/bin/bash
set -e

# ─── Colors & Symbols ───────────────────────────────────────
BOLD=$'\033[1m'
DIM=$'\033[2m'
RESET=$'\033[0m'
GREEN=$'\033[32m'
RED=$'\033[31m'
CYAN=$'\033[36m'
YELLOW=$'\033[33m'
PURPLE=$'\033[35m'
BLUE=$'\033[34m'
CHECK="${GREEN}✓${RESET}"
CROSS="${RED}✗${RESET}"
SKIP="${YELLOW}⊘${RESET}"

# ─── Parse args ──────────────────────────────────────────────
VERSION=""
DRY_RUN=false
while getopts "s:d" opt; do
    case $opt in
        s) VERSION="$OPTARG" ;;
        d) DRY_RUN=true ;;
        *) ;;
    esac
done

if [ -n "$VERSION" ]; then
    URL="https://github.com/lubikx/nebula-tv-macos-app/releases/download/v${VERSION}/Nebula.dmg"
else
    URL="https://github.com/lubikx/nebula-tv-macos-app/releases/latest/download/Nebula.dmg"
fi

# ─── Logo ─────────────────────────────────────────────────────
echo ""
echo -e "    ${DIM}·  ${PURPLE}✦${DIM}  ˚    ${CYAN}✧${DIM}    ·  ˚  ${PURPLE}✦${DIM}  ·${RESET}"
echo ""
echo -e "        ${PURPLE}╔╗╔${CYAN}╔═╗${BLUE}╔╗ ${PURPLE}╦ ╦${CYAN}╦  ${BLUE}╔═╗${RESET}"
echo -e "        ${PURPLE}║║║${CYAN}║╣ ${BLUE}╠╩╗${PURPLE}║ ║${CYAN}║  ${BLUE}╠═╣${RESET}"
echo -e "        ${PURPLE}╝╚╝${CYAN}╚═╝${BLUE}╚═╝${PURPLE}╚═╝${CYAN}╩═╝${BLUE}╩ ╩${DIM}.tv${RESET}"
echo ""
echo -e "           ${DIM}f o r   m a c O S${RESET}"
if [ -n "$VERSION" ]; then
    echo -e "              ${DIM}v${VERSION}${RESET}"
fi
echo ""
echo -e "    ${DIM}·  ${CYAN}✧${DIM}  ˚    ${PURPLE}✦${DIM}    ·  ˚  ${CYAN}✧${DIM}  ·${RESET}"
echo ""
if $DRY_RUN; then
    echo -e "    ${YELLOW}${BOLD}DRY RUN${RESET} ${DIM}— no changes will be made${RESET}"
    echo ""
fi

# ─── Helpers ─────────────────────────────────────────────────
ok()   { echo -e "    ${CHECK} $1"; }
skip() { echo -e "    ${SKIP} $1"; }
fail() { echo -e "    ${CROSS} $1"; echo -e "\n    ${RED}Installation failed.${RESET}\n"; exit 1; }

# ─── Reset settings ──────────────────────────────────────────
if $DRY_RUN; then
    skip "Reset app settings (skipped)"
else
    defaults delete eu.apptory.nebula 2>/dev/null || true
    ok "Settings cleared"
fi

# ─── Install ─────────────────────────────────────────────────
if $DRY_RUN; then
    skip "Download (skipped)"
else
    curl -sL "$URL" -o /tmp/Nebula.dmg 2>/dev/null || fail "Download failed"
    ok "Downloaded"
fi

if $DRY_RUN; then
    skip "Mount disk image (skipped)"
else
    hdiutil attach /tmp/Nebula.dmg -nobrowse -quiet 2>/dev/null || fail "Mount failed"
    ok "Mounted"
fi

if $DRY_RUN; then
    skip "Copy to /Applications (skipped)"
else
    if ! cp -R "/Volumes/Nebula/Nebula.tv.app" /Applications/ 2>/dev/null; then
        hdiutil detach "/Volumes/Nebula" -quiet 2>/dev/null
        fail "Copy failed"
    fi
    ok "Installed"
fi

if $DRY_RUN; then
    skip "Clean up (skipped)"
else
    hdiutil detach "/Volumes/Nebula" -quiet 2>/dev/null
    xattr -cr "/Applications/Nebula.tv.app" 2>/dev/null
    rm -f /tmp/Nebula.dmg
    ok "Cleaned up"
fi

# ─── Done ────────────────────────────────────────────────────
echo ""
if $DRY_RUN; then
    echo -e "    ${YELLOW}${BOLD}Dry run complete.${RESET} ${DIM}No changes were made.${RESET}"
else
    echo -e "    ${GREEN}${BOLD}Installed!${RESET} ${DIM}✦${RESET}"
fi
echo ""

# ─── Launch prompt ───────────────────────────────────────────
answer=""
if [ -t 0 ]; then
    echo -ne "    Launch now? ${DIM}[Y/n]${RESET} "
    read -r answer
elif [ -c /dev/tty ] 2>/dev/null; then
    echo -ne "    Launch now? ${DIM}[Y/n]${RESET} "
    read -r answer < /dev/tty
fi

if [ -z "$answer" ] || [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    if $DRY_RUN; then
        skip "Launch (skipped)"
    else
        open "/Applications/Nebula.tv.app"
        echo -e "    ${CHECK} Launched. Enjoy! ${DIM}✧${RESET}"
    fi
else
    echo -e "    ${DIM}Open it anytime from /Applications.${RESET}"
fi
echo ""
