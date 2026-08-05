cask "emacs-ns-static" do
  version "20260805020019,emacs-31-8b521b9"
  sha256 "d702a4afbad4943e4f31f7b32af7ee885da1adc1ace13617882a3a6f0a4c064c"

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
