cask "font-akvesoi" do
  version "34.9.0"
  sha256 "14614118701bfa668b503fe0a6da7a6419a30e4e6ceceaab7f92b973c315df76"

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
