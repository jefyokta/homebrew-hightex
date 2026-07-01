class HightexAT000011 < Formula
  desc "Desktop document editor for academic writing (pinned to v0.0.11)"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.0.11"
  license "MIT"

  livecheck do
    skip "pinned version"
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-0.0.11.AppImage"
    sha256 "221b61343320a6a8a36b7935657c644d74a4d9cc8826cd1698093e3ba471f41f"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex@0.0.11"
    end
  end

  keg_only :versioned_formula

  def install
    libexec.install "HighTex-Linux-0.0.11.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex" => "hightex@0.0.11"
    chmod 0755, bin/"hightex@0.0.11"
  end

  test do
    assert_predicate bin/"hightex@0.0.11", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
  end
end
