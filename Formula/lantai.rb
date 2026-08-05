class Lantai < Formula
  desc "BibLaTeX-backed headless reference manager"
  homepage "https://github.com/hanwenguo/lantai"
  url "https://github.com/hanwenguo/lantai/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "0af2fcbb3eac24c8a3f549e9651f97656d35fd03a9a60d41781bbd4c0d3a91ad"
  license "AGPL-3.0-only"

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
