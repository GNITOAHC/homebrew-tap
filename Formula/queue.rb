class Queue < Formula
  desc "Lightweight binary to submit queue jobs to local machine's background"
  homepage "https://github.com/gnitoahc/processq"
  license "MIT"
  version "0.2.3"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-darwin-arm64.tar.gz"
      sha256 "7407bb827fdcee234f1608f4da4716671563a27947b3e3393c36eddffe96bf8b" # darwin-arm64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-linux-amd64.tar.gz"
      sha256 "efdfc4d7f729002d3d5b6d301057d6b32b8f070a8a9e99044c13e5b058905e9e" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-linux-arm64.tar.gz"
      sha256 "a9b5fba2eba81ed9d2ae0a67bc4e8716be93878683a476bc88ea479177e2f072" # linux-arm64
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

