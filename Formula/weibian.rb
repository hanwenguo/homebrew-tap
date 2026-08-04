class Weibian < Formula
  desc "Typst document compiler and site builder"
  homepage "https://github.com/hanwenguo/weibian"
  url "https://github.com/hanwenguo/weibian/archive/refs/tags/v2.0.0-rc.5.tar.gz"
  sha256 "8733bfecb50e9017145c0bab9ce7e56b54bea166d62e534bc4698697b46e670d"
  license "GPL-3.0-only"
  revision 1

  livecheck do
    url "https://github.com/hanwenguo/weibian.git"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc\.\d+)?)$/i)
  end

  depends_on "rust" => :build

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "openssl@3"
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wb --version")
  end
end
