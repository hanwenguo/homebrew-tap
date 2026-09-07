cask "browstay" do
  version "0.1.1"
  sha256 "13390cbadb767f1eab4fd2e7274c69daf398dcbe381674e3ec1fd218b903db76"

  url "https://github.com/hanwenguo/Browstay/releases/download/v#{version}/Browstay-#{version}.zip"
  name "Browstay"
  desc "Routes external links to a browser on the current Desktop"
  homepage "https://github.com/hanwenguo/Browstay"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Browstay.app"

  zap trash: [
    "~/Library/Preferences/io.hanwen.Browstay.plist",
    "~/Library/Saved Application State/io.hanwen.Browstay.savedState",
  ]

  caveats <<~EOS
    Browstay is ad-hoc signed and is not notarized by Apple. Install it only
    after deciding to trust the upstream release:

      brew install --cask hanwenguo/tap/browstay

    If Gatekeeper blocks the first launch, approve Browstay explicitly in System
    Settings > Privacy & Security. macOS may ask for Automation permission again
    after an upgrade because an ad-hoc signature is not a persistent developer
    identity.
  EOS
end
