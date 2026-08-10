class Weibian < Formula
  desc "Typst document compiler and site builder"
  homepage "https://github.com/hanwenguo/weibian"
  url "https://github.com/hanwenguo/weibian/archive/refs/tags/v2.0.0-rc.6.tar.gz"
  sha256 "e70bdf54d95cbbff35f1876a4d24eaeebeee10acbe222244064b4f8cc311a4c2"
  license "GPL-3.0-only"

  livecheck do
    url "https://github.com/hanwenguo/weibian.git"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc\.\d+)?)$/i)
  end

  bottle do
    root_url "https://github.com/hanwenguo/homebrew-tap/releases/download/weibian-2.0.0-rc.6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7e85d6be886a463fc878eebde776500d078cde6b19409db9ce0597cffb851705"
    sha256 cellar: :any,                 arm64_linux:  "794e18454ab8c52bb9192a4ac2de1d4bf48a30ad6f846cdb215c93193e0f53e8"
    sha256 cellar: :any,                 x86_64_linux: "6156da4c4c2f1eff2aed6701662fd8f67be917b99fa81f55cbb17fe8b2d4b482"
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
    generate_completions_from_executable(bin/"wb", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wb --version")
    assert_path_exists bash_completion/"wb"
    assert_path_exists zsh_completion/"_wb"
    assert_path_exists fish_completion/"wb.fish"
  end
end
