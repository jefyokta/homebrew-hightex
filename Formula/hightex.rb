class Hightex < Formula
  desc "Desktop document editor for academic writing"
  homepage "https://github.com/jefyokta/hightex-desktop"
  version "0.0.11"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_linux do
    url "https://github.com/jefyokta/hightex-desktop/releases/download/v#{version}/HighTex-Linux-#{version}.AppImage"
    sha256 "221b61343320a6a8a36b7935657c644d74a4d9cc8826cd1698093e3ba471f41f"
  end

  on_macos do
    def install
      odie "On macOS, install via Cask instead:\n  brew install --cask hightex"
    end
  end

  def install
    libexec.install "HighTex-Linux-#{version}.AppImage" => "HighTex.AppImage"
    chmod 0755, libexec/"HighTex.AppImage"
    (libexec/".hightex-version").write version.to_s

    bin.install buildpath/"bin/hightex"
    chmod 0755, bin/"hightex"
  end

  def caveats
    <<~EOS
      HighTex has been installed.

      Run `hightex update` at any time to upgrade to the latest release.

      The AppImage requires FUSE. If you see a "fusermount" error on first run:
        sudo apt install libfuse2    # Debian / Ubuntu
        sudo dnf install fuse        # Fedora / RHEL
        sudo pacman -S fuse2         # Arch
    EOS
  end

  test do
    assert_predicate bin/"hightex", :executable?
    assert_predicate libexec/"HighTex.AppImage", :executable?
    assert_match version.to_s, (libexec/".hightex-version").read
  end
end
