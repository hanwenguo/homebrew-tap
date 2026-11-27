cask "font-akvesoi" do
  version "34.9.2"
  sha256 "b694d0cb7cb560eaaeb7bb3a8399b91398d988c13c301ce216fd254429c4ed54"

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
