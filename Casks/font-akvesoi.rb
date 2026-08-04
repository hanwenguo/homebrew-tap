cask "font-akvesoi" do
  version "34.8.0"
  sha256 "a6704672f2d2175abb4d31acdc6be9e8b8f59156a45a1405ee56e733687abdbd"

  url "https://github.com/hanwenguo/Akvesoi/releases/download/v#{version}/PkgTTC-Akvesoi-#{version}.zip",
      verified: "github.com/hanwenguo/Akvesoi/"
  name "Akvesoi"
  desc "Duo-space typeface family derived from Iosevka"
  homepage "https://github.com/hanwenguo/Akvesoi"

  livecheck do
    url :url
    strategy :github_latest
  end

  font "Akvesoi-Bold.ttc"
  font "Akvesoi-ExtraBold.ttc"
  font "Akvesoi-ExtraLight.ttc"
  font "Akvesoi-Heavy.ttc"
  font "Akvesoi-Light.ttc"
  font "Akvesoi-Medium.ttc"
  font "Akvesoi-Regular.ttc"
  font "Akvesoi-SemiBold.ttc"
  font "Akvesoi-Thin.ttc"
end
