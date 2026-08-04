class Lantai < Formula
  desc "BibLaTeX-backed headless reference manager"
  homepage "https://github.com/hanwenguo/lantai"
  url "https://github.com/hanwenguo/lantai/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "13510c59f9160261c8884416ea3f5bcb9e69b4cdcf4f4095ccd6cc156e98384d"
  license "AGPL-3.0-only"
  revision 2

  bottle do
    root_url "https://github.com/hanwenguo/homebrew-tap/releases/download/lantai-0.5.0_2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "97ce5b05be01892b421781278495827a539815a488ed4ffbb97d5933a6d9ad74"
    sha256 cellar: :any,                 arm64_linux:  "1828fd44c643ad2f483ee09a493eb448a3576ca37c6f5f931609308ed5116274"
    sha256 cellar: :any,                 x86_64_linux: "58b93f6610c11ba5ee1be1e418b22e7f2ca32054a2da3e21dae66e1f8c077da2"
  end

  depends_on "rust" => :build

  on_macos do
    depends_on arch: :arm64
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lantai --version")
  end
end
