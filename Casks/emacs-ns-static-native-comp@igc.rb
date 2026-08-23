cask "emacs-ns-static-native-comp@igc" do
  version "20260823011212,igc-07b35c8"
  sha256 "1f3863bd47343a354f8ad8942adcb0e3047a1088b4a5b95ff424e39046cae2c3"

  url "https://github.com/hanwenguo/emacs-ns-static-build/releases/download/#{version.csv.second}/Emacs-igc.tar.xz",
      verified: "github.com/hanwenguo/emacs-ns-static-build/"
  name "Emacs NS Static (IGC, Native Compilation)"
  desc "Static Emacs IGC-branch build with native compilation for Apple Silicon"
  homepage "https://github.com/hanwenguo/emacs-ns-static-build"

  livecheck do
    skip "Channel tags are tracked by the tap updater"
  end

  conflicts_with cask: [
    "emacs-app",
    "emacs-app@nightly",
    "emacs-app@pretest",
    "emacs-ns-static",
    "emacs-ns-static-native-comp",
    "emacs-ns-static@master",
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

      brew install --cask hanwenguo/tap/emacs-ns-static-native-comp@igc

    If Gatekeeper blocks the first launch, approve Emacs explicitly in System
    Settings > Privacy & Security.

    Native compilation invokes the Apple toolchain through xcrun, so Xcode or
    the Command Line Tools must be installed for it to work.
  EOS
end
