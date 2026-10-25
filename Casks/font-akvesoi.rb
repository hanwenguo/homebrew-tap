cask "font-akvesoi" do
  version "34.9.1"
  sha256 "2708d23a083014b315e9265f596c5c1e2c3edaf7aa3eb7d2f5d4b2cf3fcb8a17"

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
