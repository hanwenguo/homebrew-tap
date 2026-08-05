class Lantai < Formula
  desc "BibLaTeX-backed headless reference manager"
  homepage "https://github.com/hanwenguo/lantai"
  url "https://github.com/hanwenguo/lantai/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "0af2fcbb3eac24c8a3f549e9651f97656d35fd03a9a60d41781bbd4c0d3a91ad"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hanwenguo/homebrew-tap/releases/download/lantai-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "097e17b557758242f390a628ddcb43883ab9d9088eeb346c2d47ba9125197403"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a42a71a916b49109d70e213d621621fd01c02194126122400303a235f185a055"
    sha256 cellar: :any,                 arm64_linux:   "4612c3568b905d441ea6e22cbb1b057e8001d07c256e526f66f5a14e69bcc437"
    sha256 cellar: :any,                 x86_64_linux:  "0768d1ca410f31dbde0e21d6e005b7bd7865ec2a7527030b599389b6bd89c89b"
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
