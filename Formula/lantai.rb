class Lantai < Formula
  desc "BibLaTeX-backed headless reference manager"
  homepage "https://github.com/hanwenguo/lantai"
  url "https://github.com/hanwenguo/lantai/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "13510c59f9160261c8884416ea3f5bcb9e69b4cdcf4f4095ccd6cc156e98384d"
  license "AGPL-3.0-only"
  revision 3

  bottle do
    root_url "https://github.com/hanwenguo/homebrew-tap/releases/download/lantai-0.5.0_3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2acabc5e87971c989d330acb88f249d6a52ebcea907d9ef897cb432e765c895e"
    sha256 cellar: :any,                 arm64_linux:  "57f79d76f17279dae6106e7b53804be2db6b896127470c877a32120c6d2736d8"
    sha256 cellar: :any,                 x86_64_linux: "591bd57750ff27cccdcb46d487d6a0709f4950693766bf7c7cba5a763ce0ba64"
  end

  depends_on "rust" => :build

  on_macos do
    depends_on arch: :arm64
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      The service runs `lantai serve`, which reads the configuration file that
      `lantai init` writes. Run `lantai init` before starting it the first time.

      The Zotero-compatible endpoint must own 127.0.0.1:23119, so the daemon
      exits while Zotero is running and launchd retries it until Zotero quits.
    EOS
  end

  service do
    run [opt_bin/"lantai", "serve"]
    keep_alive true
    log_path var/"log/lantai.log"
    error_log_path var/"log/lantai.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lantai --version")
  end
end
