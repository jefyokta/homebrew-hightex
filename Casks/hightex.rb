cask "hightex" do
  version "0.0.10"

  url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Mac-#{version}-Installer.dmg"
  sha256 "64d2ce2429d713e2c78d0cc4b84f62973517e2f606fcdf2dbadde60b3ca6b2bf"

  name "HighTex"
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"

  livecheck do
    url :url
    strategy :github_latest
  end

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
