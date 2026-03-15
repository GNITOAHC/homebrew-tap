class Queue < Formula
  desc "Lightweight binary to submit queue jobs to local machine's background"
  homepage "https://github.com/gnitoahc/processq"
  license "MIT"
  version "0.2.5"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-darwin-arm64.tar.gz"
      sha256 "b5501ca6297b2f3124a646ba0560290d59c36b6ab541a9ec46f3c89895d96c89" # darwin-arm64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-linux-amd64.tar.gz"
      sha256 "4a66cfe3432e6b3a7b95c9335a7e62bee888ab8b8dc1f0c00e8b7413ce74ad16" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-linux-arm64.tar.gz"
      sha256 "f31a29fa9e934a4370019f6ec4c0417954cc909df3443b40d796100782a92919" # linux-arm64
    end
  else
    odie "Unsupported platform."
  end

  def install
    # system "go", "build", *std_go_args(ldflags: "-s -w")
    bin.install "queue"
  end

  test do
    output = shell_output("#{bin}/queue -v")
    assert_match "queue v#{version}", output
  end
end

