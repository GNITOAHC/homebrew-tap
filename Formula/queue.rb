class Queue < Formula
  desc "Lightweight binary to submit queue jobs to local machine's background"
  homepage "https://github.com/gnitoahc/processq"
  license "MIT"
  version "0.2.4"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-darwin-arm64.tar.gz"
      sha256 "78e32d20014368de61298a7924f6d9f4fa3c582ff2e0bc23e50aadfed635c601" # darwin-arm64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-linux-amd64.tar.gz"
      sha256 "d39069446a2975eb59bc6a697494698630c0152ef73b6ac3e431166b82051d0d" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/processq/releases/download/v#{version}/queue-v#{version}-linux-arm64.tar.gz"
      sha256 "c9f101b4c54d05da8974028d7d608f61e6ee8085b57263d6921e5f5111a4cd23" # linux-arm64
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

