class HightexAT070 < Formula
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.7.0"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.7.0.AppImage"
    sha256 "658a92cac91d2c14f2621651029a4d216f365327b5efbc3e66a101673ce9db43"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex@0.7.0"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "HighTex-Linux-0.7.0.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@0.7.0"
    chmod 0755, bin/"hightex@0.7.0"
  end

  test do
    assert_predicate bin/"hightex@0.7.0", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
