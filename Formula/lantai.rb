class Lantai < Formula
  desc "BibLaTeX-backed headless reference manager"
  homepage "https://github.com/hanwenguo/lantai"
  license "AGPL-3.0-only"
  revision 1

  on_macos do
    on_arm do
      url "https://github.com/hanwenguo/lantai/releases/download/v0.5.0/lantai-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "a37caf85aaf492342081607df520c49b04eacf8fe45b7fb4d3612a3637b1061a"
    end
    on_intel do
      url "https://github.com/hanwenguo/lantai/releases/download/v0.5.0/lantai-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "5169aed9af119f7a89a183635f42c19331eb499e5c3444ed6d811bd4730e0592"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hanwenguo/lantai/releases/download/v0.5.0/lantai-0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c6a974e865e980027ea2ff5f19f09d12c22815da20c097027a6587a57a24ec1b"
    end
    on_intel do
      url "https://github.com/hanwenguo/lantai/releases/download/v0.5.0/lantai-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0b9b012799962ae9920670db6db2ff876c88d269f3a978040d46eb863e9af789"
    end
  end

  def install
    bin.install "lantai"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lantai --version")
  end
end
