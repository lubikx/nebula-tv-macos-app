#!/bin/bash
set -e

VERSION="${1:-latest}"

if [ "$VERSION" = "latest" ]; then
    URL="https://github.com/lubikx/nebula-macos-app/releases/latest/download/Nebula.dmg"
else
    URL="https://github.com/lubikx/nebula-macos-app/releases/download/v${VERSION}/Nebula.dmg"
fi

echo "Installing Nebula ${VERSION}..."
curl -sL "$URL" -o /tmp/Nebula.dmg
hdiutil attach /tmp/Nebula.dmg -nobrowse -quiet
cp -R "/Volumes/Nebula/Nebula.app" /Applications/
hdiutil detach "/Volumes/Nebula" -quiet
xattr -cr /Applications/Nebula.app
rm /tmp/Nebula.dmg
echo "Nebula installed! Open it from /Applications."
