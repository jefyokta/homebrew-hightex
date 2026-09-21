cask "hightex" do
  version "0.7.0"

  url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Mac-0.7.0-Installer.zip"
  sha256 "43f18f617a99b39b86d7a4d26184b2b39650c0af6790349fd2fc411554a2b4b7"

  name "HighTex"
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"

  livecheck do
    skip "pinned version"
  end

  depends_on macos: :ventura

  app "HighTex.app"

  postflight do
    cli = cask.tap.path/"bin/hightex"
    target = Pathname("#{HOMEBREW_PREFIX}/bin/hightex")

    raise "HighTex CLI not found: #{cli}" unless cli.file?

    system_command "/bin/cp",
      args: [cli.to_s, target.to_s],
      sudo: false

    system_command "/bin/chmod",
      args: ["0755", target.to_s],
      sudo: false

    system_command "/usr/bin/xattr",
      args: ["-cr", "#{appdir}/HighTex.app"],
      sudo: false
  end

  uninstall_postflight do
    target = Pathname("#{HOMEBREW_PREFIX}/bin/hightex")

    target.delete if target.exist?
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