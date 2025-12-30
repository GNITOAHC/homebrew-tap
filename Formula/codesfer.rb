class Codesfer < Formula
  desc "Transfer your files easily"
  homepage "https://github.com/gnitoahc/codesfer"
  license "MIT"
  version "0.1.0"

  # depends_on "go" => :build

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-arm64.gz"
      sha256 "b8e7514f95b9b1c70ee7d55e59268f2a791be0a600145d3b3878b0f7136ea6db" # darwin-arm64
    else
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-darwin-amd64.gz"
      sha256 "a959a04a181c71434f30eca8462cbc88c256a19d6d00a885d53c4f6f04a4c67d" # darwin-amd64
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-amd64.gz"
      sha256 "82db237ce0876532309c093daee088c3ef9be12841339cee35f0141eced77152" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/GNITOAHC/codesfer/releases/download/v#{version}/codesfer-v#{version}-linux-arm64.gz"
      sha256 "af1e254be6f74fda96d80a8762453c7c7e87ab3a1e9576e0605e1e10448dfd28" # linux-arm64
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


