#!/usr/bin/env bash
# make-versioned.sh
# Generate a pinned hightex@X.Y.Z Cask + Formula pair so users can install
# a specific release that does not auto-update:
#
#   brew install --cask hightex@0.0.9
#   brew install hightex@0.0.9
#
# This does NOT touch the main `hightex` Cask/Formula (which always tracks
# latest) — it creates a separate, frozen file pair next to it.
#
# Usage:
#   chmod +x make-versioned.sh
#   ./make-versioned.sh 0.0.9

set -euo pipefail

VERSION="${1:?Usage: $0 <version>   example: $0 0.0.9}"
TAG="v${VERSION}"
OWNER="jefyokta"
REPO="hightex-desktop"
BASE="https://github.com/${OWNER}/${REPO}/releases/download/${TAG}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DMG_FILE="HighTex-Mac-${VERSION}-Installer.dmg"
APPIMAGE_FILE="HighTex-Linux-${VERSION}.AppImage"

CASK_OUT="${DIR}/Casks/hightex@${VERSION}.rb"
FORMULA_OUT="${DIR}/Formula/hightex@${VERSION}.rb"

if [[ -f "$CASK_OUT" ]]; then
  echo "error: ${CASK_OUT} already exists. Remove it first if you want to regenerate." >&2
  exit 1
fi

fetch_sha256() {
  local filename="$1"
  local url="${BASE}/${filename}"
  local tmp="/tmp/hightex-pin-${filename}"
  printf "  %-55s" "${filename}" >&2
  if ! curl -fsSL -L "$url" -o "$tmp" 2>/dev/null; then
    echo " FAILED" >&2
    echo "error: could not download ${url}. Check that release ${TAG} exists." >&2
    exit 1
  fi
  shasum -a 256 "$tmp" | awk '{print $1}'
  rm -f "$tmp"
  echo " ok" >&2
}

echo "Fetching SHA256 for ${TAG}..."
SHA_DMG="$(fetch_sha256 "$DMG_FILE")"
SHA_APPIMAGE="$(fetch_sha256 "$APPIMAGE_FILE")"
echo ""

CLASS_SUFFIX="$(echo "$VERSION" | tr '.' '0' | tr -cd '0-9')"
CLASS_NAME="HightexAT${CLASS_SUFFIX}"

echo "Writing ${CASK_OUT}..."
cat > "$CASK_OUT" <<RUBY
cask "hightex@${VERSION}" do
  version "${VERSION}"

  url "https://github.com/${OWNER}/${REPO}/releases/download/v#{version}/${DMG_FILE}"
  sha256 "${SHA_DMG}"

  name "HighTex"
  desc "Desktop document editor for academic writing "
  homepage "https://github.com/${OWNER}/${REPO}"

  livecheck do
    skip "pinned version"
  end

  conflicts_with cask: "hightex"
  depends_on macos: ">= :ventura"

  app "HighTex.app"

  bin = "#{HOMEBREW_PREFIX}/bin/hightex"
  binary "#{staged_path}/bin/hightex", target: bin

  postflight do
    system_command "/usr/bin/xattr",
      args: ["-cr", "#{appdir}/HighTex.app"],
      sudo: false
  end

  uninstall delete: "#{HOMEBREW_PREFIX}/bin/hightex"

  zap trash: [
    "~/Library/Application Support/hightex-desktop",
    "~/Library/Application Support/HighTex",
    "~/Library/Caches/hightex-desktop-updater",
    "~/Library/Logs/HighTex",
    "~/Library/Preferences/com.hightex.app.plist",
    "~/Library/Saved Application State/com.hightex.app.savedState",
  ]
end
RUBY

echo "Writing ${FORMULA_OUT}..."
cat > "$FORMULA_OUT" <<RUBY
class ${CLASS_NAME} < Formula
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/${OWNER}/${REPO}"
  version "${VERSION}"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/${OWNER}/${REPO}/releases/download/v#{version}/${APPIMAGE_FILE}"
    sha256 "${SHA_APPIMAGE}"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\\n  brew install --cask hightex@${VERSION}"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "${APPIMAGE_FILE}" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@${VERSION}"
    chmod 0755, bin/"hightex@${VERSION}"
  end

  test do
    assert_predicate bin/"hightex@${VERSION}", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
RUBY

echo ""
echo "Committing..."
cd "$DIR"
git add "Casks/hightex@${VERSION}.rb" "Formula/hightex@${VERSION}.rb"
git commit -m "add: pin hightex@${VERSION}"
git push

echo ""
echo "Done. Users can now install this exact version with:"
echo ""
echo "  brew install --cask hightex@${VERSION}   # macOS"
echo "  brew install hightex@${VERSION}           # Linux"
