class HightexAT00100 < Formula
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.1.0"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.1.0.AppImage"
    sha256 "da1a6633a6206297865f95f0a1e0fd876544a88153e7ebd09a712862230d0191"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex@0.1.0"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "HighTex-Linux-0.1.0.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@0.1.0"
    chmod 0755, bin/"hightex@0.1.0"
  end

  test do
    assert_predicate bin/"hightex@0.1.0", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
