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
