class Queue < Formula
  desc "Lightweight binary to submit queue jobs to local machine's background"
  homepage "https://github.com/gnitoahc/processq"
  license "MIT"
  version "0.1.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-darwin-arm64.tar.gz"
      sha256 "e776b19c1ac0ea6875ea5eaf52ef34208e79e9c1ffb7e7d0516c57373d309b55" # darwin-arm64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/md-html/releases/download/v#{version}/queue-v#{version}-linux-amd64.tar.gz"
      sha256 "b585998e616383ff3fef1bb28b6111593594aedd08626abaa52157c629502566" # linux-amd64
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

