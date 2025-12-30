class Codesfer < Formula
  desc "Transfer your files easily"
  homepage "https://github.com/gnitoahc/codesfer"
  license "MIT"
  version "0.1.0"

  # depends_on "go" => :build

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-arm64.gz"
      sha256 "7c36e78ae81dfcd353cb1b6949e02803f11e5f736526f2546e5399061c2a9969" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-amd64.gz"
      sha256 "ae980422cc53ca1096c6f916c6b5c5261c194bd26c0e51482b76fb0fa3e796c2" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-amd64.gz"
      sha256 "7435161d2552cd35a0b61dee5727d092e469dfdf0d9a3c4b14d6d8558e00505d" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-arm64.gz"
      sha256 "b8a8b908d3a2e7380ad19b193f1b3443b7b5595869550b210f14e59b4a5007f9" # linux-arm64
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


