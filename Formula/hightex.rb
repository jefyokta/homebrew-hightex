class Hightex < Formula
  desc "HighTex command-line interface and Linux desktop application"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.7.0"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  depends_on :linux

  url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.7.0.AppImage"
  sha256 "658a92cac91d2c14f2621651029a4d216f365327b5efbc3e66a101673ce9db43"

  def install
    libexec.install "HighTex-Linux-0.7.0.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"

    (libexec/".hightex-version").write version.to_s

    bin.install "../bin/hightex"
  end

  test do
    assert_predicate bin/"hightex", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end