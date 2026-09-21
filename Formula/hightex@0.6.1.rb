class HightexAT0601 < Formula
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.6.1"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.6.1.AppImage"
    sha256 "5f1df58b19f58d4948e4567a734b02116f4bcc96c47578b1acdff79a2f99713e"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex@0.6.1"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "HighTex-Linux-0.6.1.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@0.6.1"
    chmod 0755, bin/"hightex@0.6.1"
  end

  test do
    assert_predicate bin/"hightex@0.6.1", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
