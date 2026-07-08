class HightexAT00302 < Formula
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.3.2"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.3.2.AppImage"
    sha256 "27d32fe4b1ce2eb27dfc32643e1942f4305b0cd2f8744c8f3ef7b81de1b5b476"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex@0.3.2"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "HighTex-Linux-0.3.2.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@0.3.2"
    chmod 0755, bin/"hightex@0.3.2"
  end

  test do
    assert_predicate bin/"hightex@0.3.2", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
