class MdHtml < Formula
  desc "Lightweight markdown to html converter"
  homepage "https://github.com/gnitoahc/md-html"
  license "MIT"
  version "0.2.0"

  # depends_on "go" => :build
  
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/md-html/releases/download/v0.1.0/md-html-v#{version}-darwin-arm64.tar.gz"
      sha256 "5695911532eb2a3ab64991b0711651613a407de7f0039d591b1f2546d5c72b4a" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/md-html/releases/download/v0.1.0/md-html-v#{version}-darwin-amd64.tar.gz"
      sha256 "cb37b264c7c8b0c5123ae9a87aca77e7891d6d4194447586594818f24dce1e80" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/md-html/releases/download/v0.1.0/md-html-v#{version}-linux-amd64.tar.gz"
      sha256 "c282e224073150c81e6b5389d04e4163eccd49f3670b34c395097504d6e840e5" # linux-amd64
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

