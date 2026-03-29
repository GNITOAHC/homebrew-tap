class Codesfer < Formula
  desc "Transfer your files easily"
  homepage "https://www.codesfer.io"
  license "MIT"
  version "0.1.5"

  # depends_on "go" => :build

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-arm64.tar.gz"
      sha256 "744c2eaf6c20008b224a461f8d89065dadd396cee716f7517425b5ef05de0be8" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-amd64.tar.gz"
      sha256 "7c48d65d9a690a2018ffb5169fbaac6902ad0cccbc1b76aafc397a9e889da8c8" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-amd64.tar.gz"
      sha256 "1a1e42ded97d4187311297808e3024d2874d3a9d8bd477ec6c97e6ff013259d1" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-arm64.tar.gz"
      sha256 "5f754235d6d8ad8378d98a24fac5e54fe7462d3862a2e1c0f10687110ce483c6" # linux-arm64
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


