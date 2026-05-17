class MdHtml < Formula
  desc "Lightweight markdown to html converter"
  homepage "https://github.com/gnitoahc/md-html"
  license "MIT"
  version "0.2.4"

  # depends_on "go" => :build
  
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-darwin-arm64.tar.gz"
      sha256 "ff9cd45ac7a0bbcd720469ccc24e2bd985f53cb157167484a5c9b6ec4843c153" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-darwin-amd64.tar.gz"
      sha256 "a6e3a92a3eed86f26d92da071bc9721b254be7d6975c70505482dc4be000e192" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/md-html-v#{version}-linux-amd64.tar.gz"
      sha256 "190b6131e52527bdcb23c771ca6695fb156cb6fc27ef6dae15a3d8cebd78b46b" # linux-amd64
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

