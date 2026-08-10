class Lantai < Formula
  desc "BibLaTeX-backed headless reference manager"
  homepage "https://github.com/hanwenguo/lantai"
  url "https://github.com/hanwenguo/lantai/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "bcac94c68f70a3919dab3ddf022fb63eed62e60bd37561c84474522a49966181"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/hanwenguo/homebrew-tap/releases/download/lantai-0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "af47f5b0254cc17a8f4c9804f4cb8ef1139e60ac754b3cd578c711626ba25dcb"
    sha256 cellar: :any,                 arm64_linux:  "24857e124ba76f48b160290e9530815a683123250bc46b03b7974ddeb78b3954"
    sha256 cellar: :any,                 x86_64_linux: "364f3177de5df9068d65722ce23a608004c95ac549e76a570b9e8b4a5fc972a5"
  end

  depends_on "rust" => :build

  on_macos do
    depends_on arch: :arm64
  end

  def install
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"lantai", "completions")
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
    assert_path_exists bash_completion/"lantai"
    assert_path_exists zsh_completion/"_lantai"
    assert_path_exists fish_completion/"lantai.fish"
  end
end
