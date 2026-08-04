class Weibian < Formula
  desc "Typst document compiler and site builder"
  homepage "https://github.com/hanwenguo/weibian"
  version "2.0.0-rc.4"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/hanwenguo/weibian/releases/download/v2.0.0-rc.4/wb-aarch64-apple-darwin.tar.gz"
      sha256 "fbc998a847d8cde4bde82f0ba3aec35fef643df58dae249685e7f97d3f19c643"
    end
    on_intel do
      url "https://github.com/hanwenguo/weibian/releases/download/v2.0.0-rc.4/wb-x86_64-apple-darwin.tar.gz"
      sha256 "1eea4d625a4efae0e52f94ae706bcdbd1cdc3b3c37b72a202e7aaa3da441c763"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hanwenguo/weibian/releases/download/v2.0.0-rc.4/wb-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "865854286bd55d44ee5f6efe9388adb015b4b84ce0182ff5a437cbcb6014604d"
    end
    on_intel do
      url "https://github.com/hanwenguo/weibian/releases/download/v2.0.0-rc.4/wb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c13b5f19093dc9f101d47ad41bd67c4778c4980f96985bb10a70bf0f0eaf2dc4"
    end
  end

  def install
    bin.install "wb"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wb --version")
  end
end
