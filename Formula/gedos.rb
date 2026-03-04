class Gedos < Formula
  desc "Autonomous AI agent for macOS. Your Mac, working while you're not."
  homepage "https://github.com/g-dos/gedos"
  url "https://github.com/g-dos/gedos/archive/refs/tags/v0.9.11.tar.gz"
  sha256 "4192fa02027bed5c4aa905e76789c102d9c56d01909c182ec573dc43bff6193e"
  license "Apache-2.0"
  head "https://github.com/g-dos/gedos.git", branch: "main"

  depends_on "python@3.12"
  depends_on "ollama" => :recommended
  depends_on "ffmpeg" => :recommended

  def install
    virtualenv_install_with_resources
  end

  def post_install
    (var/"gedos").mkpath
    (etc/"gedos").mkpath
  end

  def caveats
    <<~EOS
      Before running Gedos, configure your LLM:

        brew install ollama
        ollama pull llama3.2

      Then run:
        gedos

      To enable Pilot Mode (remote autonomous execution):
        Add TELEGRAM_BOT_TOKEN to ~/.gedos/.env
        gedos  (will start in Telegram Mode automatically)

      Full setup guide:
        https://github.com/g-dos/gedos/blob/main/docs/setup.md

    EOS
  end

  test do
    system "#{bin}/gedos", "--version"
  end
end
