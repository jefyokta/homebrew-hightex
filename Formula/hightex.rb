class Hightex < Formula
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.7.0"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_macos do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Mac-0.7.0-Installer.dmg"
    sha256 "9f151c1561adb6d7d6237a4c36e2e23be66a7dc4ca1d014060266645c78bdc8c"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.7.0.AppImage"
    sha256 "658a92cac91d2c14f2621651029a4d216f365327b5efbc3e66a101673ce9db43"
  end

  keg_only :versioned_formula

  def install
    if OS.mac?
      mountpoint = buildpath/"mnt"
      mkdir mountpoint

      system "/usr/bin/hdiutil", "attach",
             "-nobrowse",
             "-readonly",
             "-mountpoint", mountpoint,
             cached_download

      begin
        prefix.install mountpoint/"HighTex.app"

        system "/usr/bin/xattr",
               "-cr",
               prefix/"HighTex.app"

        (bin/"hightex@0.7.0").write <<~SH
          #!/bin/sh
          exec "#{prefix}/HighTex.app/Contents/MacOS/HighTex" "$@"
        SH

        chmod 0755, bin/"hightex@0.7.0"
      ensure
        system "/usr/bin/hdiutil", "detach", mountpoint
      end
    else
      libexec.install "HighTex-Linux-0.7.0.AppImage" => "HighTex.AppImage"
      chmod 0755, libexec/"HighTex.AppImage"

      (bin/"hightex@0.7.0").write <<~SH
        #!/bin/sh
        exec "#{libexec}/HighTex.AppImage" "$@"
      SH

      chmod 0755, bin/"hightex@0.7.0"
    end
  end

  test do
    assert_predicate bin/"hightex@0.7.0", :executable?
  end
end