class MdHtml < Formula
  desc "Lightweight markdown to html converter"
  homepage "https://github.com/gnitoahc/md-html"
  license "MIT"
  version "0.2.6"

  # depends_on "go" => :build
  
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-darwin-arm64.tar.gz"
      sha256 "c67a77bef015ff5f02f014dd231ea5b70b505d90b54c835e95b4ccc7a931ab52" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-darwin-amd64.tar.gz"
      sha256 "7b48deef43d4afc3cd278ada35e49e5796d44efe2fa738745f14d70001a63da6" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-linux-amd64.tar.gz"
      sha256 "d40c0f97cd5d9c4f966ce4ec7c8c3b5616f607d4f2729a2d0ea664d4f310eab3" # linux-amd64
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

