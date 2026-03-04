class Gedos < Formula
  include Language::Python::Virtualenv

  desc "Autonomous AI agent for macOS. Your Mac, working while you're not."
  homepage "https://github.com/g-dos/gedos"
  url "https://github.com/g-dos/gedos/archive/refs/tags/v0.9.11.1.tar.gz"
  sha256 "bbeee87a219421125d30454a12198f4b27a019f657362fbdc649767f1c2a7ebc"
  license "Apache-2.0"
  head "https://github.com/g-dos/gedos.git", branch: "main"

  depends_on "python@3.12"
  depends_on "ffmpeg" => :recommended

  def install
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install %w[setuptools wheel rich pyyaml python-dotenv]
    system libexec/"bin/python", "-m", "pip", "install", "--no-deps", "--no-build-isolation", buildpath
    bin.install_symlink libexec/"bin/gedos"
  end

  def caveats
    <<~EOS
      Before running Gedos, configure your LLM:

        brew install ollama
        ollama pull llama3.2

      Then run:
        gedos

      To enable Pilot Mode:
        Add TELEGRAM_BOT_TOKEN to ~/.gedos/.env
        gedos

      Docs: https://github.com/g-dos/gedos/blob/main/docs/setup.md
    EOS
  end

  test do
    system "#{bin}/gedos", "--version"
  end
end
