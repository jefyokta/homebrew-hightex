class HightexAT000014 < Formula
  desc "Desktop document editor for academic writing (pinned to v0.0.14)"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.0.14"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.0.14.AppImage"
    sha256 "37041d421291fa114a76177614077de091df0d46ef83412025edf3584ec63f36"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex@0.0.14"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "HighTex-Linux-0.0.14.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@0.0.14"
    chmod 0755, bin/"hightex@0.0.14"
  end

  test do
    assert_predicate bin/"hightex@0.0.14", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
