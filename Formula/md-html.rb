class MdHtml < Formula
  desc "Lightweight markdown to html converter"
  homepage "https://github.com/gnitoahc/md-html"
  license "MIT"
  version "0.2.5"

  # depends_on "go" => :build
  
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-darwin-arm64.tar.gz"
      sha256 "c9aa468d943ef881761a3a55eabcb5d4fca402381b415ae7d5ea2e83cf5d8a65" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-darwin-amd64.tar.gz"
      sha256 "2ea3accdba0720d4cf883eb49f072d2b3e15d57970ceb07d50e3876d351f4b3c" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-linux-amd64.tar.gz"
      sha256 "63caa435955d537d119861290691c82c4f98c4b84e285cfe07ebafadbef292d8" # linux-amd64
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

