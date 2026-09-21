class Hightex < Formula
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.7.0"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_macos do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Mac-0.7.0.zip"
    sha256 "MAC_ZIP_SHA256"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.7.0.AppImage"
    sha256 "658a92cac91d2c14f2621651029a4d216f365327b5efbc3e66a101673ce9db43"
  end

  keg_only :versioned_formula

  def install
    if OS.mac?
      prefix.install "HighTex.app"

      system "/usr/bin/xattr",
             "-cr",
             prefix/"HighTex.app"
    else
      libexec.install "HighTex-Linux-0.7.0.AppImage" => "HighTex.AppImage"
      chmod 0755, libexec/"HighTex.AppImage"
    end
  end

  test do
    if OS.mac?
      assert_predicate prefix/"HighTex.app", :directory?
    else
      assert_predicate libexec/"HighTex.AppImage", :executable?
    end
  end
end