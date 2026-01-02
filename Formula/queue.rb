class Queue < Formula
  desc "Lightweight binary to submit queue jobs to local machine's background"
  homepage "https://github.com/gnitoahc/processq"
  license "MIT"
  version "0.2.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-darwin-arm64.tar.gz"
      sha256 "944e8c09c0e208fa622676453ffc89ebc67b3060e0451eb51760965ef7a501c0" # darwin-arm64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-linux-amd64.tar.gz"
      sha256 "0d42fb25766de4d7e3d1b4c9f81b56e6a1ef3c6496856948f2febfb24f825d81" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-linux-arm64.tar.gz"
      sha256 "1777fc7297fb8cc4ffb5b25f5ada581c415f81849c1fd4a499c6c042c715630c" # linux-arm64
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

