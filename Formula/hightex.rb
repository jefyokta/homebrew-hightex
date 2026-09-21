class Hightex < Formula
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.7.0"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_macos do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Mac-0.7.0-Installer.zip"
    sha256 "43f18f617a99b39b86d7a4d26184b2b39650c0af6790349fd2fc411554a2b4b7"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.7.0.AppImage"
    sha256 "658a92cac91d2c14f2621651029a4d216f365327b5efbc3e66a101673ce9db43"
  end

  def install
    if OS.mac?
      prefix.install Pathname.pwd => "HighTex.app"

      system "/usr/bin/xattr",
             "-cr",
             prefix/"HighTex.app"
    else
      libexec.install "HighTex-Linux-0.7.0.AppImage" => "HighTex.AppImage"
      chmod 0755, libexec/"HighTex.AppImage"

      (libexec/".hightex-version").write version.to_s
    end

    bin.install tap.path/"bin/hightex"
  end

  test do
    assert_predicate bin/"hightex", :executable?

    if OS.mac?
      assert_predicate prefix/"HighTex.app", :directory?
      assert_predicate prefix/"HighTex.app/Contents/MacOS/HighTex", :executable?
    else
      assert_predicate libexec/"HighTex.AppImage", :executable?
      assert_equal version.to_s, (libexec/".hightex-version").read.chomp
    end
  end
end