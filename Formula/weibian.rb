class Weibian < Formula
  desc "Typst document compiler and site builder"
  homepage "https://github.com/hanwenguo/weibian"
  version "2.0.0-rc.5"
  license "GPL-3.0-only"

  bottle do
    root_url "https://github.com/hanwenguo/homebrew-tap/releases/download/weibian-2.0.0-rc.5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a9554082c0e729d85d1cc9c34852bcb72014137eac7b2d0a8f24c63a43c694dd"
    sha256 cellar: :any_skip_relocation, sequoia:       "ad729b339d5d174e7f4742329d6e88dc99ed3a2f8898c0f4ab384ae7d1eaf311"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "593de0163afc1708babeb3dd2f2a4e3ac537c9e4e12fb9a35b099344f301d4cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a7d96918643b389e6c3b67cc2f1ec13bd00f55dffd76b21ef8d798829d1a6b9e"
  end

  on_macos do
    on_arm do
      url "https://github.com/hanwenguo/weibian/releases/download/v2.0.0-rc.5/wb-aarch64-apple-darwin.tar.gz"
      sha256 "01cb8a54a2d839a7960a324ee412e9f9be649acbe2db6ae87130749df1063fe3"
    end
    on_intel do
      url "https://github.com/hanwenguo/weibian/releases/download/v2.0.0-rc.5/wb-x86_64-apple-darwin.tar.gz"
      sha256 "9134594b660f7e94bad1988e9381c6eb07861f237d1e4c0bee8f8fa821758a55"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hanwenguo/weibian/releases/download/v2.0.0-rc.5/wb-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0c3341f282905c86f28e34228aedadee12869a1c56da4d8c56483897562335e8"
    end
    on_intel do
      url "https://github.com/hanwenguo/weibian/releases/download/v2.0.0-rc.5/wb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "10e09f93b6f44b3abf60b26ec044da4e7843dc0083aa6071f52ae5ae48232f85"
    end
  end

  def install
    bin.install "wb"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wb --version")
  end
end
