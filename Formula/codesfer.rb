class Codesfer < Formula
  desc "Transfer your files easily"
  homepage "https://www.codesfer.io"
  license "MIT"
  version "0.1.14"

  # depends_on "go" => :build

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-arm64.tar.gz"
      sha256 "c091026740bebf9fd77c5918256c9d70ec3af336626975f234604bcadf120d2a" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-amd64.tar.gz"
      sha256 "b482807c0962886ff26ffdca44622b8b6fd0844602e5c71c06f6383e1c78ade1" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-amd64.tar.gz"
      sha256 "3aa481ec824fd00cdafe06c4e8d44589912ec15cdf6c4c0d1c81d3263cd1e3eb" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-arm64.tar.gz"
      sha256 "8389eedddb0d7855fd44471d73b898bdf321cf4f03896b31a10120da400dc4fc" # linux-arm64
    end
  else
    odie "Unsupported platform."
  end

  def install
    # system "go", "build", *std_go_args(ldflags: "-s -w")
    bin.install "codesfer"
  end

  test do
    output = shell_output("#{bin}/md-html -v")
    assert_match "codesfer version #{version}", output
  end
end


