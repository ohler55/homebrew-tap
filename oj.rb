class Oj < Formula
  desc "A JSON parser and visualization tool."
  homepage "https://github.com/ohler55/ojg"
  url "https://github.com/ohler55/ojg/archive/refs/tags/v1.19.4.tar.gz"
  sha256 "d9f07e35f4b3cb31336e598f1a380b904cf5c6b94bec45e3f7eb9930812ee187"

  depends_on "go"

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"
    ENV["GOFLAGS"] = "-mod=vendor"
    ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
    (buildpath/"src/github.com/ohler55/ojg").install buildpath.children
    cd "src/github.com/ohler55/ojg" do
      system "go", "build", "-o", bin/"oj", "./cmd/oj/main.go"
    end
  end

  test do
    assert_match /usage: oj/, shell_output("#{bin}/oj -h", 0)
  end
end
