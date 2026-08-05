class Lantai < Formula
  desc "BibLaTeX-backed headless reference manager"
  homepage "https://github.com/hanwenguo/lantai"
  url "https://github.com/hanwenguo/lantai/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "13510c59f9160261c8884416ea3f5bcb9e69b4cdcf4f4095ccd6cc156e98384d"
  license "AGPL-3.0-only"
  revision 4

  bottle do
    root_url "https://github.com/hanwenguo/homebrew-tap/releases/download/lantai-0.5.0_4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1986914974135fdafa9ea850915b7939042e913db6b74458db1f9689479c84a6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9f4cfc12af52c051e1d843d72e55f66ba4ea8df55e8ac55874772a06379b2654"
    sha256 cellar: :any,                 arm64_linux:   "cf7a32632af01f135715928bb6abd56c92746ee40ef43fae6eb58c64f2182c10"
    sha256 cellar: :any,                 x86_64_linux:  "e4e75fae2eb90c866e10e8dd7d43e11abfd44dea528c94f656fb8c45a7ca1ad2"
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
