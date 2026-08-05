#!/usr/bin/env ruby
# typed: strict
# frozen_string_literal: true

require "digest"
require "json"
require "net/http"
require "time"
require "uri"

# Resolves upstream releases into Homebrew versions and checksums.
module TapUpdater
  ROOT = File.expand_path("..", __dir__).freeze
  API_ROOT = "https://api.github.com"
  USER_AGENT = "hanwenguo-homebrew-tap-updater"

  module_function

  def http_response(uri, authenticated:, redirects: 5)
    raise "too many redirects while fetching #{uri}" if redirects.negative?

    request = Net::HTTP::Get.new(uri)
    request["Accept"] = "application/vnd.github+json"
    request["User-Agent"] = USER_AGENT
    request["X-GitHub-Api-Version"] = "2022-11-28"
    if authenticated && (token = ENV.fetch("GITHUB_TOKEN", nil)) && !token.empty?
      request["Authorization"] = "Bearer #{token}"
    end

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end

    case response
    when Net::HTTPSuccess
      response
    when Net::HTTPRedirection
      location = URI.join(uri, response.fetch("location"))
      http_response(location, authenticated: location.host == "api.github.com", redirects: redirects - 1)
    else
      raise "#{response.code} #{response.message} while fetching #{uri}"
    end
  end

  def api_json(path)
    JSON.parse(http_response(URI("#{API_ROOT}#{path}"), authenticated: true).body)
  end

  def releases(repository)
    api_json("/repos/#{repository}/releases?per_page=100").reject { |release| release.fetch("draft") }
  end

  def latest_release(repository, pattern)
    releases(repository).find { |release| pattern.match?(release.fetch("tag_name")) } ||
      raise("no release matching #{pattern.inspect} in #{repository}")
  end

  def release_asset(release, name)
    release.fetch("assets").find { |asset| asset.fetch("name") == name } ||
      raise("release #{release.fetch("tag_name")} has no #{name} asset")
  end

  def download_sha256(url)
    Digest::SHA256.hexdigest(http_response(URI(url), authenticated: false).body)
  end

  def asset_sha256(asset)
    match = /\Asha256:([0-9a-f]{64})\z/.match(asset["digest"].to_s)
    return match[1] if match

    download_sha256(asset.fetch("browser_download_url"))
  end

  def release_timestamp(release)
    Time.iso8601(release.fetch("published_at")).utc.strftime("%Y%m%d%H%M%S")
  end

  def replace_stanza!(content, stanza, value)
    pattern = /^(  #{Regexp.escape(stanza)}\s+)"[^"]+"/
    matches = content.scan(pattern).length
    raise "expected one #{stanza} stanza, found #{matches}" if matches != 1

    content.sub!(pattern) { "#{Regexp.last_match(1)}#{value.dump}" }
  end

  def update_file(relative_path, version:, sha256:, url:, formula: false, update_url: true)
    path = File.join(ROOT, relative_path)
    content = File.read(path)
    previous_url = content[/^  url\s+"([^"]+)"/, 1]
    previous_version = content[/^  version\s+"([^"]+)"/, 1]
    raise "#{relative_path} has no URL stanza" unless previous_url
    raise "#{relative_path} has no version stanza" if !formula && !previous_version

    replace_stanza!(content, "version", version) unless formula
    replace_stanza!(content, "sha256", sha256)
    replace_stanza!(content, "url", url) if update_url

    if formula && previous_url != url
      # The match begins at the blank line above the block, so it already
      # carries the separator `depends_on` needs. Putting one back leaves the
      # doubled blank line `brew style` rejects as Layout/EmptyLines.
      content.sub!(/\n  bottle do\n.*?^  end\n/m, "")
      content.sub!(/^  revision\s+\d+\n/, "")
    end

    File.write(path, content) if content != File.read(path)
  end

  def update_formula(relative_path, repository)
    release = latest_release(repository, /\Av\d/)
    tag = release.fetch("tag_name")
    version = tag.delete_prefix("v")
    url = "https://github.com/#{repository}/archive/refs/tags/#{tag}.tar.gz"
    update_file(relative_path,
                version: version,
                sha256:  download_sha256(url),
                url:     url,
                formula: true)
  end

  def update_asset_cask(relative_path, repository, asset_name_for:)
    release = latest_release(repository, /\Av\d/)
    tag = release.fetch("tag_name")
    version = tag.delete_prefix("v")
    asset = release_asset(release, asset_name_for.call(version))
    update_file(relative_path,
                version:    version,
                sha256:     asset_sha256(asset),
                url:        asset.fetch("browser_download_url"),
                update_url: false)
  end

  def update_emacs_cask(relative_path, release_list, tag_pattern, asset_name)
    release = release_list.find { |candidate| tag_pattern.match?(candidate.fetch("tag_name")) } ||
              raise("no Emacs release matching #{tag_pattern.inspect}")
    asset = release_asset(release, asset_name)
    version = "#{release_timestamp(release)},#{release.fetch("tag_name")}"
    update_file(relative_path,
                version:    version,
                sha256:     asset_sha256(asset),
                url:        asset.fetch("browser_download_url"),
                update_url: false)
  end

  def run
    update_formula("Formula/lantai.rb", "hanwenguo/lantai")
    update_formula("Formula/weibian.rb", "hanwenguo/weibian")

    update_asset_cask("Casks/font-akvesoi.rb", "hanwenguo/Akvesoi",
                      asset_name_for: ->(version) { "PkgTTC-Akvesoi-#{version}.zip" })
    update_asset_cask("Casks/browstay.rb", "hanwenguo/Browstay",
                      asset_name_for: ->(version) { "Browstay-#{version}.zip" })

    emacs_releases = releases("hanwenguo/emacs-ns-static-build")
    update_emacs_cask("Casks/emacs-ns-static.rb", emacs_releases, /\Aemacs-31-/, "Emacs.tar.xz")
    update_emacs_cask("Casks/emacs-ns-static-master.rb", emacs_releases, /\Amaster-/, "Emacs-master.tar.xz")
    update_emacs_cask("Casks/emacs-ns-static-igc.rb", emacs_releases, /\Aigc-/, "Emacs-igc.tar.xz")
  end
end

TapUpdater.run if $PROGRAM_NAME == __FILE__
