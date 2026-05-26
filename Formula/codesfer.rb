class Codesfer < Formula
  desc "Transfer your files easily"
  homepage "https://www.codesfer.io"
  license "MIT"
  version "0.1.8"

  # depends_on "go" => :build

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-arm64.tar.gz"
      sha256 "0fcd12de81d8ce44cf3ec88aac278ac284bd46c906ed0230d89d443e4f7b2beb" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-amd64.tar.gz"
      sha256 "5287244f64590aa8cfea18f2e81ab56fc62ae384477e8a887ace438bb0c245a6" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-amd64.tar.gz"
      sha256 "bfaf61fd86a0afa87583f74c2ec2e61a716f3ed60efe47ae79ffd7da08733cea" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-arm64.tar.gz"
      sha256 "bea5ff3d13bf0a832cda7abbc1f2045f9cc29e542166a60be56172fe8d29a410" # linux-arm64
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


