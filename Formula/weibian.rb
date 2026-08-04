class Weibian < Formula
  desc "Typst document compiler and site builder"
  homepage "https://github.com/hanwenguo/weibian"
  url "https://github.com/hanwenguo/weibian/archive/refs/tags/v2.0.0-rc.3.tar.gz"
  version "2.0.0-rc.3"
  sha256 "fd77c90097e993f775e8cc25e6a9b59bfa8cb25d6922fd1e08b24a7a4698ceee"
  license "GPL-3.0-only"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wb --version")
  end
end
