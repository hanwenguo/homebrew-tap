class Weibian < Formula
  desc "Typst document compiler and site builder"
  homepage "https://github.com/hanwenguo/weibian"
  url "https://github.com/hanwenguo/weibian/archive/refs/tags/v2.0.0-rc.5.tar.gz"
  sha256 "8733bfecb50e9017145c0bab9ce7e56b54bea166d62e534bc4698697b46e670d"
  license "GPL-3.0-only"
  revision 2

  livecheck do
    url "https://github.com/hanwenguo/weibian.git"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc\.\d+)?)$/i)
  end

  bottle do
    root_url "https://github.com/hanwenguo/homebrew-tap/releases/download/weibian-2.0.0-rc.5_2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2a2997b968d5e85d37afff125a181fd9f86e231289caba9e5e981ce8022af54d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "183f2911aa0eee1a7911579a511ed575b205d3a346a4dbf1345c033455183682"
    sha256 cellar: :any,                 arm64_linux:   "c2a50d1e476c60869df98950738caa44c9f3f726c9eb4815b7331c8611cc6782"
    sha256 cellar: :any,                 x86_64_linux:  "ec33a27e2544578bbb2ca1d2db06fadc98ffe0f902f6477fc3626317fce3e809"
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
