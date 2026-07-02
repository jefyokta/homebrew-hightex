cask "hightex" do
  version "0.0.14"

  url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Mac-#{version}-Installer.dmg"
  sha256 "206eeb5882fc07994791bc89fe699f73e617b37954ef5b533a0f6ccdef089d55"

  name "HighTex"
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "HighTex.app"

  postflight do
    system_command "/usr/bin/xattr",
      args: ["-cr", "#{appdir}/HighTex.app"],
      sudo: false

    bin_dir = "#{HOMEBREW_PREFIX}/bin"
    FileUtils.mkdir_p(bin_dir)
    FileUtils.cp(
      "#{Tap.fetch("jefyokta", "hightex").path}/bin/hightex",
      "#{bin_dir}/hightex"
    )
    FileUtils.chmod(0755, "#{bin_dir}/hightex")
  end

  uninstall_postflight do
    FileUtils.rm_f("#{HOMEBREW_PREFIX}/bin/hightex")
  end
  
  zap trash: [
    "~/Library/Application Support/hightex-desktop",
    "~/Library/Application Support/HighTex",
    "~/Library/Caches/hightex-desktop-updater",
    "~/Library/Logs/HighTex",
    "~/Library/Preferences/com.hightex.app.plist",
    "~/Library/Saved Application State/com.hightex.app.savedState",
  ]
end
