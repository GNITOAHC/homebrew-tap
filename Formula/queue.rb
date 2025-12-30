class Queue < Formula
  desc "Lightweight binary to submit queue jobs to local machine's background"
  homepage "https://github.com/gnitoahc/processq"
  license "MIT"
  version "0.2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-darwin-arm64.tar.gz"
      sha256 "70e9f37818a2728f9338469d37c91ddb379a5d7617e276c315e8d93c349b8de3" # darwin-arm64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-linux-amd64.tar.gz"
      sha256 "d0c73cd48fa2e138d10567cb596230a00c293f92b613adae0c799cec12be5ea2" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-linux-arm64.tar.gz"
      sha256 "570865e39a0fae41ff18e68fc347505eef6151622c153f529d1849dea552d013" # linux-arm64
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

