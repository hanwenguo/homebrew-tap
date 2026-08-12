cask "emacs-ns-static" do
  version "20260812010815,emacs-31-b9c2b2d"
  sha256 "f5eb3d188c54e23b0eaeb558b81765a3e27f6baf0976c986b81d8ef709e1b217"

  url "https://github.com/hanwenguo/emacs-ns-static-build/releases/download/#{version.csv.second}/Emacs.tar.xz",
      verified: "github.com/hanwenguo/emacs-ns-static-build/"
  name "Emacs NS Static (Emacs 31)"
  desc "Daily static Emacs 31 build for Apple Silicon"
  homepage "https://github.com/hanwenguo/emacs-ns-static-build"

  livecheck do
    skip "Daily channel tags are tracked by the tap updater"
  end

  conflicts_with cask: [
    "emacs-app",
    "emacs-app@nightly",
    "emacs-app@pretest",
    "emacs-ns-static-igc",
    "emacs-ns-static-master",
  ]
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Emacs.app"
  app "Emacs Client.app"
  binary "#{appdir}/Emacs.app/Contents/MacOS/bin/emacs"
  binary "#{appdir}/Emacs.app/Contents/MacOS/bin/emacsclient"
  binary "#{appdir}/Emacs.app/Contents/MacOS/bin/ebrowse"
  binary "#{appdir}/Emacs.app/Contents/MacOS/bin/etags"

  caveats <<~EOS
    This Emacs build is ad-hoc signed and is not notarized by Apple. Install it
    only after deciding to trust the upstream release:

      brew install --cask hanwenguo/tap/emacs-ns-static

    If Gatekeeper blocks the first launch, approve Emacs explicitly in System
    Settings > Privacy & Security.
  EOS
end
