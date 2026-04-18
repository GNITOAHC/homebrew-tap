class Codesfer < Formula
  desc "Transfer your files easily"
  homepage "https://www.codesfer.io"
  license "MIT"
  version "0.1.6"

  # depends_on "go" => :build

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-arm64.tar.gz"
      sha256 "27a4443532c816c05af30d2b8a43976bf30f0911af98ce9426f45695ce1c6a79" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-amd64.tar.gz"
      sha256 "1ace90e2243093d7e7a02e3f9b8ce62798fb15e6d50b0cdda1102709133ea05b" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-amd64.tar.gz"
      sha256 "f81c8cdda58de7a99293fc6d3b2643de58f5602f44d0f99a81bbf00a1e257ab2" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-arm64.tar.gz"
      sha256 "8134e8dab84461c2a5196d34f5b4cc29aff381c624e5a88febb08093c671e261" # linux-arm64
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


