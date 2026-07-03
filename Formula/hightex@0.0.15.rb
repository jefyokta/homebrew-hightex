class HightexAT000015 < Formula
  desc "Desktop document editor for academic writing (pinned to v0.0.15)"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.0.15"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.0.15.AppImage"
    sha256 "166f2734d4061debb78c061b44acbb7ecde73539e11a1bd0a701d7b8041c8294"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex@0.0.15"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "HighTex-Linux-0.0.15.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@0.0.15"
    chmod 0755, bin/"hightex@0.0.15"
  end

  test do
    assert_predicate bin/"hightex@0.0.15", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
