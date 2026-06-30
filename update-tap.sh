#!/usr/bin/env bash
# update-tap.sh
# Bump the main `hightex` Cask/Formula (the ones that always track latest)
# to a new release. Does NOT touch any pinned hightex@X.Y.Z files — those
# are frozen on purpose, use make-versioned.sh to create new ones.
#
# Usage:
#   chmod +x update-tap.sh
#   ./update-tap.sh 0.0.11

set -euo pipefail

VERSION="${1:?Usage: $0 <version>   example: $0 0.0.11}"
TAG="v${VERSION}"
OWNER="jefyokta"
REPO="hightex-desktop"
BASE="https://github.com/${OWNER}/${REPO}/releases/download/${TAG}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DMG_FILE="HighTex-Mac-${VERSION}-Installer.dmg"
APPIMAGE_FILE="HighTex-Linux-${VERSION}.AppImage"

fetch_sha256() {
  local filename="$1"
  local url="${BASE}/${filename}"
  local tmp="/tmp/hightex-tap-${filename}"
  printf "  %-55s" "${filename}" >&2
  if ! curl -fsSL -L "$url" -o "$tmp" 2>/dev/null; then
    echo " FAILED" >&2
    echo "error: could not download ${url}." >&2
    echo "Make sure release ${TAG} is published and the file name matches." >&2
    exit 1
  fi
  shasum -a 256 "$tmp" | awk '{print $1}'
  rm -f "$tmp"
  echo " ok" >&2
}

echo "Fetching SHA256 for release ${TAG}..."
SHA_DMG="$(fetch_sha256 "$DMG_FILE")"
SHA_APPIMAGE="$(fetch_sha256 "$APPIMAGE_FILE")"

echo ""
echo "  DMG      ${SHA_DMG}"
echo "  AppImage ${SHA_APPIMAGE}"
echo ""

patch_rb() {
  local file="$1" sha="$2"
  python3 - <<PYEOF
import re
path = "${file}"
with open(path) as f:
    content = f.read()
content = re.sub(r'version "[^"]*"', 'version "${VERSION}"', content)
content = re.sub(r'sha256 "[^"]*"', 'sha256 "${sha}"', content)
with open(path, "w") as f:
    f.write(content)
PYEOF
}

echo "Patching Casks/hightex.rb (latest-tracking)..."
patch_rb "${DIR}/Casks/hightex.rb" "$SHA_DMG"

echo "Patching Formula/hightex.rb (latest-tracking)..."
patch_rb "${DIR}/Formula/hightex.rb" "$SHA_APPIMAGE"

echo ""
echo "Committing..."
cd "$DIR"
git add Casks/hightex.rb Formula/hightex.rb
if git diff --staged --quiet; then
  echo "Nothing changed. Already at ${VERSION}."
  exit 0
fi
git commit -m "release: bump latest to ${TAG}"
git push

echo ""
echo "Done."
echo ""
echo "  brew tap jefyokta/hightex"
echo "  brew install --cask hightex   # macOS, always latest"
echo "  brew install hightex           # Linux, always latest"
echo ""
echo "To also pin this version so it can be installed permanently:"
echo "  ./make-versioned.sh ${VERSION}"
