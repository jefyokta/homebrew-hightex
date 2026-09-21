class HightexAT060 < Formula
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.6.0"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.6.0.AppImage"
    sha256 "91314b371349ba9dbff2249dfbbb0ae0358ab0c0af72e383902243dc2bbd5cba"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex@0.6.0"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "HighTex-Linux-0.6.0.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@0.6.0"
    chmod 0755, bin/"hightex@0.6.0"
  end

  test do
    assert_predicate bin/"hightex@0.6.0", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
