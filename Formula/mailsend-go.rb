# This file was generated by GoReleaser. DO NOT EDIT.
class MailsendGo < Formula
  desc "Command line tool to send mail via SMTP protocol"
  homepage "https://github.com/muquit/mailsend-go"
  version "1.0.8"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/muquit/mailsend-go/releases/download/v1.0.8/mailsend-go_1.0.8_mac-64bit.tar.gz"
    sha256 "e6a5f01793035ce562c192d7d40f5b2bb19ea4e50be19e660ce03eb2b3b193b5"
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/muquit/mailsend-go/releases/download/v1.0.8/mailsend-go_1.0.8_linux-64bit.tar.gz"
      sha256 "ef538fbad954f445340c1dc163e6849b7ee08c57a907311d806be6f81c493234"
    end
  end

  def install
    bin.install "mailsend-go"
  end
end
