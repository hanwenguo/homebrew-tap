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

  bottle do
    root_url "https://github.com/hanwenguo/homebrew-tap/releases/download/weibian-2.0.0-rc.5_1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "5fcd791457b3d7de7c7be72081a3f16b82ead525a1ac94197239b04d5987218c"
    sha256 cellar: :any,                 arm64_linux:  "d1c02abe7b87c2002120d4eab280c3a89b061678870e5e442851e5eeb1e6a432"
    sha256 cellar: :any,                 x86_64_linux: "7535cb76f0cc7a9ea16068382b926586b246f34744c76b31800bda7bc618ccb9"
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
