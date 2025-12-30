#!/usr/bin/env ruby
require "net/http"
require "json"

# Configuration
FORMULAE = {
  "md-html" => {
    repo: "gnitoahc/md-html",
    script: "script/md-html.rb",
    file: "Formula/md-html.rb"
  },
  "queue" => {
    repo: "gnitoahc/processq",
    script: "script/queue.rb",
    file: "Formula/queue.rb"
  },
  "codesfer" => {
    repo: "gnitoahc/codesfer",
    script: "script/codesfer.rb",
    file: "Formula/codesfer.rb"
  }
}

def get_current_version(file_path)
  File.read(file_path).match(/version "([\d\.]+)"/)[1]
rescue StandardError => e
  puts "Error reading version from #{file_path}: #{e.message}"
  nil
end

def get_latest_version(repo)
  url = "https://api.github.com/repos/#{repo}/releases/latest"
  uri = URI(url)
  
  request = Net::HTTP::Get.new(uri)
  if ENV["GITHUB_TOKEN"]
    request["Authorization"] = "token #{ENV["GITHUB_TOKEN"]}"
  end

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(request)
  end
  
  unless response.is_a?(Net::HTTPSuccess)
    puts "Error fetching release for #{repo}: #{response.code} #{response.message}"
    return nil
  end
  
  json = JSON.parse(response.body)
  tag = json["tag_name"]
  tag.sub(/^v/, "") # Remove 'v' prefix if present
end

FORMULAE.each do |name, config|
  puts "Checking #{name}..."
  
  current_version = get_current_version(config[:file])
  if current_version.nil?
    puts "  Could not determine current version. Skipping."
    next
  end
  
  latest_version = get_latest_version(config[:repo])
  if latest_version.nil?
    puts "  Could not determine latest version. Skipping."
    next
  end
  
  puts "  Current: #{current_version}, Latest: #{latest_version}"
  
  if current_version != latest_version
    puts "  Update available! Running update script..."
    system("ruby", config[:script], latest_version)
  else
    puts "  Up to date."
  end
  puts "---"
end
