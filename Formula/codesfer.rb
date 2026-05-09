class Codesfer < Formula
  desc "Transfer your files easily"
  homepage "https://www.codesfer.io"
  license "MIT"
  version "0.1.7"

  # depends_on "go" => :build

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-arm64.tar.gz"
      sha256 "7fd1c9fd0c92c21a72d25a439ad9b5c071ffb3a67e734f7458ad5e2c1722cdcd" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-amd64.tar.gz"
      sha256 "00bbce849c8617636cbf662b6521817b9661fde5c94afc7922b4d150a1c34efd" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-amd64.tar.gz"
      sha256 "475d2a7ab186d757f00288ddbe9d2a81834e308f18ef7499c0a7380d982632fb" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-arm64.tar.gz"
      sha256 "8c70e20c6c017023d690db186d7db7d14cb1163acabc42752c702960869e8a1a" # linux-arm64
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


