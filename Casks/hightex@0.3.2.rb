cask "hightex@0.3.2" do
  version "0.3.2"

  url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Mac-0.3.2-Installer.dmg"
  sha256 "676096da0681b52259e1c9fb410d06abd9b290f51981eda28d0ade15dc8bacf0"

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
