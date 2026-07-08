class HightexAT00301 < Formula
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.3.1"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.3.1.AppImage"
    sha256 "2b25ad8b66f2b1a456b43fa79420673119c84477b49059e6e4b4e038f5398fe3"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex@0.3.1"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "HighTex-Linux-0.3.1.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@0.3.1"
    chmod 0755, bin/"hightex@0.3.1"
  end

  test do
    assert_predicate bin/"hightex@0.3.1", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
