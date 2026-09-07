cask "font-akvesoi" do
  version "34.8.1"
  sha256 "b902ed62d719edb218e86b6dbff4fd4105be4cb34627c8c13771175b8fe76ab8"

  url "https://github.com/hanwenguo/Akvesoi/releases/download/v#{version}/PkgTTC-Akvesoi-#{version}.zip"
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
