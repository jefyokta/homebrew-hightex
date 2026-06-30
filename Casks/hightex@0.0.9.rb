cask "hightex@0.0.9" do
  version "0.0.9"

  url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Mac-#{version}-Installer.dmg"
  sha256 "FILL_SHA256_DMG_FOR_0_0_9"

  name "HighTex"
  desc "Desktop document editor for academic writing (pinned to v#{version})"
  homepage "https://github.com/jefyokta/hightex-desktop"

  # Versioned casks do not livecheck — they are intentionally frozen.
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
