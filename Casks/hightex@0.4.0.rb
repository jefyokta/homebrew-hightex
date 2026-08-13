cask "hightex@0.4.0" do
  version "0.4.0"

  url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Mac-0.4.0-Installer.dmg"
  sha256 "aa81c44c177b680c0b277aed2ed3f23b90796913b2c25a5b267b70736744a55f"

  name "HighTex"
  desc "Desktop document editor for academic writing "
  homepage "https://github.com/jefyokta/hightex-desktop"

  livecheck do
    skip "pinned version"
  end

  conflicts_with cask: "hightex"
  depends_on macos: :ventura

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
