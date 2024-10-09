require "net/http"
require "json"
require "digest"

version = ARGV[0]
if version == nil
  abort "Usage: release.rb [x.y.z]"
else
  version = version.gsub(/[a-z-]*/i, "")
end

puts "Releasing md-html on Homebrew: v#{version}"

url = "https://api.github.com/repos/gnitoahc/md-html/releases/tags/v#{version}"
response = Net::HTTP.get_response(URI(url))
unless response.is_a?(Net::HTTPSuccess)
  abort "Did not find release: v#{version} [status: #{response.code}]"
end

release = JSON.parse(response.body)
puts "Found release: #{release["name"]}"

assets = {}
for asset in release["assets"]
  filename = asset["name"]
  url = asset["browser_download_url"]

  if !filename.end_with?(".tar.gz")
    puts "Skipping asset: #{filename}"
    next
  end

  begin
    response = Net::HTTP.get_response(URI(url))
    url = response["location"]
  end while response.is_a?(Net::HTTPRedirection)

  unless response.is_a?(Net::HTTPSuccess)
    abort "Did not find asset: #{filename} [status: #{response.code}]"
  end

  sha256 = Digest::SHA256.hexdigest(response.body)
  puts "Found asset: #{filename} [#{sha256}]"

  assets[filename] = sha256
end

release_file = ""
File.open("Formula/md-html.rb", "r") do |file|
  file.each_line do |line|
    striped = line.strip
    new_line = line

    # Change version
    if striped.start_with?("version")
      new_line = line.gsub(/"[0-9\.]{1,}"/, "\"#{version}\"")
      release_file += new_line
      next
    end

    # Update SHA
    if striped.start_with?("sha256")
      indicator = striped[(striped.index("#") + 2)..-1].strip

      sha256 = ""
      assets.each do |filename, info|
        if filename.end_with?("#{indicator}.tar.gz")
          if assets[filename] == nil
            abort "assets[#{filename}] not found"
          end

          sha256 = assets[filename]
          break
        end
      end

      if sha256 == ""
        abort "#{indicator} not found"
      end

      new_line = line.gsub(/"[A-Fa-f0-9]{1,}"/, "\"#{sha256}\"")
      release_file += new_line
      next
    end

    release_file += new_line
  end
end

File.write("Formula/md-html.rb", release_file)
puts "Saved Formula/md-html.rb, Done"
