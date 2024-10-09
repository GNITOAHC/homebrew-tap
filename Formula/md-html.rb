class MdHtml < Formula
  desc "Lightweight markdown to html converter"
  homepage "https://github.com/gnitoahc/md-html"
  license "MIT"
  version "0.1.0"

  # depends_on "go" => :build
  
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/md-html/releases/download/v0.1.0/md-html-v#{version}-darwin-arm64.tar.gz"
      sha256 "f5c7e08a0dd422920e7146044f06506dde9dcb39248806180f6ab9a2a89e62ac" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/md-html/releases/download/v0.1.0/md-html-v#{version}-darwin-amd64.tar.gz"
      sha256 "9b133f518c140737d3b783eb00a5dcd443c89b37b1f0dd38eedc6feef4b9bf72" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/md-html/releases/download/v0.1.0/md-html-v#{version}-linux-amd64.tar.gz"
      sha256 "284439e11e6033fde0ceddf0c582caeae4dc41df1a78f1844087968d6e02186e" # linux-amd64
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
    assert_match "md-html v0.1.0", output
  end
end

