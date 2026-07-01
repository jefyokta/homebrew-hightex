class HightexAT000010 < Formula
  desc "Desktop document editor for academic writing (pinned to v0.0.10)"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.0.10"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.0.10.AppImage"
    sha256 "1035e1c7295696491d4c8ac984a20ab45ef73259c7b23bb5080216b24639e009"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex@0.0.10"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "HighTex-Linux-0.0.10.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@0.0.10"
    chmod 0755, bin/"hightex@0.0.10"
  end

  test do
    assert_predicate bin/"hightex@0.0.10", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
