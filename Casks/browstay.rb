cask "browstay" do
  version "0.1.1"
  sha256 "13390cbadb767f1eab4fd2e7274c69daf398dcbe381674e3ec1fd218b903db76"

  url "https://github.com/hanwenguo/Stayfari/releases/download/v0.1.1/Browstay-0.1.1.zip",
      verified: "github.com/hanwenguo/Stayfari/"
  name "Browstay"
  desc "Routes external links to a browser on the current Desktop"
  homepage "https://github.com/hanwenguo/Stayfari"

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
    Browstay is ad-hoc signed and is not notarized by Apple. To make the trust
    decision explicitly at install time, use:

      brew install --cask --no-quarantine hanwenguo/tap/browstay

    A normal quarantined install may require approval in System Settings >
    Privacy & Security. macOS may ask for Automation permission again after an
    upgrade because an ad-hoc signature is not a persistent developer identity.
  EOS
end
