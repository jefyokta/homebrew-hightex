class HightexAT00400 < Formula
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.4.0"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.4.0.AppImage"
    sha256 "acd622fa587401ea5e01d42b4fc40fcd567639a1f0d7cec62a5b9b8a0f916553"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex@0.4.0"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "HighTex-Linux-0.4.0.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@0.4.0"
    chmod 0755, bin/"hightex@0.4.0"
  end

  test do
    assert_predicate bin/"hightex@0.4.0", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
