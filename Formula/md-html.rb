class MdHtml < Formula
  desc "Lightweight markdown to html converter"
  homepage "https://github.com/gnitoahc/md-html"
  license "MIT"
  version "0.2.3"

  # depends_on "go" => :build
  
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-darwin-arm64.tar.gz"
      sha256 "9e78f91450baad769022dccf1b66b36b2ab4ae2ab642b2f2fe51564eb2c41bc6" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-darwin-amd64.tar.gz"
      sha256 "cf20e19df77beef6601982ece9f28edbb0df4f60ea2d34d1930781dfe8130279" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-linux-amd64.tar.gz"
      sha256 "a8a3548297ae1bec3ebf36f20333dd7f2bd7cbda0999ced1d1b9ebdb16be35ed" # linux-amd64
    end
  else
    odie "Unsupported platform."
  end

  def install
    # system "go", "build", *std_go_args(ldflags: "-s -w")
    bin.install "md-html"
  end

  test do
    output = shell_output("#{bin}/md-html -v")
    assert_match "md-html v#{version}", output
  end
end

