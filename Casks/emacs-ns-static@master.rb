cask "emacs-ns-static@master" do
  version "20260907015906,master-962b0d0"
  sha256 "e9f9e391e9e05e34c216192072f2bf2775a649ea4424cc0a0a7c14124204185b"

  url "https://github.com/hanwenguo/emacs-ns-static-build/releases/download/#{version.csv.second}/Emacs-master.tar.xz"
  name "Emacs NS Static (Master)"
  desc "Daily static Emacs master build for Apple Silicon"
  homepage "https://github.com/hanwenguo/emacs-ns-static-build"

  livecheck do
    skip "Daily channel tags are tracked by the tap updater"
  end

  conflicts_with cask: [
    "emacs-app",
    "emacs-app@nightly",
    "emacs-app@pretest",
    "emacs-ns-static",
    "emacs-ns-static-native-comp",
    "emacs-ns-static-native-comp@igc",
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

      brew install --cask hanwenguo/tap/emacs-ns-static@master

    If Gatekeeper blocks the first launch, approve Emacs explicitly in System
    Settings > Privacy & Security.
  EOS
end
