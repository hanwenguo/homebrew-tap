class Lantai < Formula
  desc "BibLaTeX-backed headless reference manager"
  homepage "https://github.com/hanwenguo/lantai"
  url "https://github.com/hanwenguo/lantai/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "13510c59f9160261c8884416ea3f5bcb9e69b4cdcf4f4095ccd6cc156e98384d"
  license "AGPL-3.0-only"
  revision 4

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
