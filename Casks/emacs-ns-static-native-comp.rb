cask "emacs-ns-static-native-comp" do
  version "20260828081450,emacs-native-comp-ca0a913"
  sha256 "991afa4eeeedf7749034ea8a324e45639c1d651c56b4391a632734cbd6e5ef21"

  url "https://github.com/hanwenguo/emacs-ns-static-build/releases/download/#{version.csv.second}/Emacs-native-comp.tar.xz",
      verified: "github.com/hanwenguo/emacs-ns-static-build/"
  name "Emacs NS Static (Emacs 31, Native Compilation)"
  desc "Daily static Emacs 31 build with native compilation for Apple Silicon"
  homepage "https://github.com/hanwenguo/emacs-ns-static-build"

  livecheck do
    skip "Daily channel tags are tracked by the tap updater"
  end

  conflicts_with cask: [
    "emacs-app",
    "emacs-app@nightly",
    "emacs-app@pretest",
    "emacs-ns-static",
    "emacs-ns-static-native-comp@igc",
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

      brew install --cask hanwenguo/tap/emacs-ns-static-native-comp

    If Gatekeeper blocks the first launch, approve Emacs explicitly in System
    Settings > Privacy & Security.

    Native compilation invokes the Apple toolchain through xcrun, so Xcode or
    the Command Line Tools must be installed for it to work.
  EOS
end
