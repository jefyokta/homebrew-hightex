class HightexAT009 < Formula
  desc "Desktop document editor for academic writing (pinned to v0.0.9)"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.0.9"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-#{version}.AppImage"
    sha256 "FILL_SHA256_APPIMAGE_FOR_0_0_9"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex@0.0.9"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "HighTex-Linux-#{version}.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@0.0.9"
    chmod 0755, bin/"hightex@0.0.9"
  end

  test do
    assert_predicate bin/"hightex@0.0.9", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
