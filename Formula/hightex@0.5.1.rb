class HightexAT051 < Formula
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.5.1"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.5.1.AppImage"
    sha256 "54e5767f70634fd665b3616022acd0ad75984ff63cfc63a82cb4b6718bc540e6"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex@0.5.1"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "HighTex-Linux-0.5.1.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@0.5.1"
    chmod 0755, bin/"hightex@0.5.1"
  end

  test do
    assert_predicate bin/"hightex@0.5.1", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
