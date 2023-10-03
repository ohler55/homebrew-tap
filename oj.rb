class Oj < Formula
  desc "A JSON parser and visualization tool."
  homepage "https://github.com/ohler55/ojg"
  url "https://github.com/ohler55/ojg/archive/refs/tags/v1.19.3.tar.gz"
  sha256 "077c01e84d04d8ccb7d4634388623ff63a0f216e4b448dce0c03944c0d5c4bf3"

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
