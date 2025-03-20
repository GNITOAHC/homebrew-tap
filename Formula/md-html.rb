class MdHtml < Formula
  desc "Lightweight markdown to html converter"
  homepage "https://github.com/gnitoahc/md-html"
  license "MIT"
  version "0.2.1"

  # depends_on "go" => :build
  
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-darwin-arm64.tar.gz"
      sha256 "a55ff93e4a03ccfbd349a8d4c5dc781a37b711a7a70a151cbe3ccdc58fbfc29f" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-darwin-amd64.tar.gz"
      sha256 "7e03957c0cba94a30781fb218085c68d10dd34aa8bb1208f458c77b9753e4a54" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-linux-amd64.tar.gz"
      sha256 "f43422fa98ef285e1c590a21fe1a795d495acfe793a1b6f556c2c4a481476971" # linux-amd64
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

